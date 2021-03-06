#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

// mini java only deals with 8 byte signed ints
#define mj_int int64_t
#define u8 uint8_t

// comment this line if you don't want debug prints
#define DEBUG_PRINTS

// when a malloc fails we print and exit
static void check_alloc(void* ptr) {
    if (ptr == NULL) {
        printf("Failed to allocate memory.\n");
        exit(1);
    }
}

// resizable array of void*
typedef struct {
    void** data;
    mj_int len;
    mj_int cap;
} Array;

void arr_init(Array* arr, mj_int cap) {
    arr->len = 0;
    arr->cap = cap;
    arr->data = (void**) malloc(sizeof(void*) * arr->cap);
    check_alloc(arr->data);
}

void arr_push(Array* arr, void* x) {
    if (arr->len == arr->cap) {
        // we need to resize
        arr->cap *= 2;
        arr->data = (void**) realloc(arr->data, sizeof(void*) * arr->cap);
        check_alloc(arr->data);
    }

    arr->data[arr->len] = x;
    arr->len++;
}

// our heap is just a bump allocator
struct {
    u8* data;
    mj_int end;
    mj_int size;
} heap;

#define INIT_HEAP_SIZE 64000  // 64 kb

static void heap_init() {
    heap.end = 0;
    heap.size = INIT_HEAP_SIZE;
    heap.data = malloc(heap.size);
    check_alloc(heap.data);
}

// we will define this later...
static void collect_garbage(void);

static void* heap_alloc(mj_int n_bytes) {
    // if heap is full, we need to run gc
    if (heap.end + n_bytes > heap.size) {
        collect_garbage();
    }

    // if the heap is still full, we need to resize the heap
    if (heap.end + n_bytes > heap.size) {
        // linear growing strategy because
        // heap.size should already be large
        heap.size += INIT_HEAP_SIZE;
        heap.data = realloc(heap.data, heap.size);
        check_alloc(heap.data);
    }

    void* res = heap.data + heap.end;
    heap.end += n_bytes;
    return res;
}

// used in program.asm
bool heap_contains_ptr(const u8* ptr) {
    return heap.data <= (u8*) ptr && (u8*) ptr <= heap.data + heap.size;
}

// CODE GENERATED BY OUR MINIJAVA COMPILER
// this would all be assembly,
// but for the sake of this demo some of it is in C

// we will have a class called Foo with two methods: f and g
// and w fields: n an int, bar a Bar object pointer

// Bar will have a single field that is Foo and no methods

// declare object structs ahead of time
struct Foo;
struct Bar;

static struct BarVtable {
    // empty vtable
} bar_vtable;

struct Bar {
    struct BarVtable* bar_vtable;
    struct Foo* foo;
};

// these are the prototypes for Foo's methods
void f();
void g();

static struct FooVtable {
    void (*f)();
    void (*g)();
} foo_vtable = { &f, &g };

struct Foo {
    struct FooVtable* foo_vtable;
    mj_int n;
    struct Bar* bar;
};

// These should be generated by the minijava compiler. Sample implementations
// are defined in program.asm
void set_stack_top();
void add_ptrs_on_stack(Array* arr);

void g(struct Foo* this) {
    // just adding some random values on the stack
    mj_int x = 4, y = 1;
    x++;
    y++;

    // make bar point to this
    struct Bar* bar_g = heap_alloc(sizeof(struct Bar));
    bar_g->bar_vtable = &bar_vtable;
    bar_g->foo = this;
}

void f(struct Foo* this) {
    mj_int x = 5, y = 2;
    x++;
    y++;

    struct Bar* bar_f = heap_alloc(sizeof(struct Bar));
    bar_f->bar_vtable = &bar_vtable;
    bar_f->foo = this;

    this->bar = bar_f;
    this->foo_vtable->g(this);
}

void asm_main(void) {
    set_stack_top();

    struct Foo* foo = heap_alloc(sizeof(struct Foo));
    foo->foo_vtable = &foo_vtable;
    foo->n = 7;
    foo->bar = NULL;

    mj_int x = 7;
    foo->foo_vtable->f(foo);

    // this is the current state of references
    // bar_g -> foo <-> bar_f
    // nothing points to bar_g and its pointer is off the stack, so
    // it should be gone when we garbage collect
    // foo's pointer is on the stack so it should persist
    // bar_f should also persist because foo references it
    collect_garbage();
}

// END OF CODE GENERATED BY OUR MINIJAVA COMPILER

void collect_garbage(void) {
#ifdef DEBUG_PRINTS
    printf("Collecting the garbage...\n");
#endif

    Array active_pointers;
    arr_init(&active_pointers, 64);
    add_ptrs_on_stack(&active_pointers);

#ifdef DEBUG_PRINTS
    printf("%lld quads found on stack that are pointers in global heap: ", active_pointers.len);
    for (int i = 0; i < active_pointers.len - 1; i++) {
        printf("%p, ", active_pointers.data[i]);
    }
    printf("%p\n", active_pointers.data[active_pointers.len - 1]);
#endif

    // TODO: implement garbage collection:
    //
    // for each object in active_pointers
    //  add all pointer fields in that object to active_pointers if they are not there already
    // repeat this until no more new pointers are added
    // quick sort active_pointers
    // set the heap size to 0
    // for each active_pointer in active_pointers
    //  copy it to the heap base pointer + heap size
    //  increase heap size according to the object's size
}

int main() {
    heap_init();
    asm_main();
}
