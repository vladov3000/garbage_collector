// note that we are using the C preprocessor
// this may require a special flag depending on the compiler you are using

// this will blow up if you are compiling without the C preprocessor
#define THIS_FILE_NEEDS_CPP
THIS_FILE_NEEDS_CPP THIS_FILE_NEEDS_CPP

// comment this line if you don't want debug prints
#define DEBUG_PRINTS

// calling convention helpers
#define ARG0 %rdi
#define ARG1 %rsi
#define ARG2 %rdx
#define ARG3 %rcx

.data

fmt_cur_prev_rbp:
    .string "CUR_RBP: %p PREV_RBP: %p\n"

fmt_indented_ptr:
    .string "   %p\n"

fmt_stack_top:
    .string "STACK_TOP: %p\n"

stack_top:
    .quad 0

.text
.extern _printf
.extern _arr_push
.extern _heap_contains_ptr

.global _add_ptrs_on_stack
.global _set_stack_top

_set_stack_top:
  movq %rbp, stack_top(%rip)
  ret

_add_ptrs_on_stack:
  // Scans quads on stack frames up to stack_top. Adds those to
  // out array if the values are inside the heap
  //
  // Args:
  //   %rdi: Array* out_array

  pushq %rbp
  pushq %r12
  #define PREV_RBP %r12
  movq 8(%rsp), PREV_RBP

  pushq %r13
  pushq %r14
  pushq %r15
  pushq %rbx
  movq %rsp, %rbp
  subq $-8, %rsp  // alignment

  #define CUR_RBP  %r13
  movq (PREV_RBP), CUR_RBP

  #define OUT_ARRAY %r15
  movq ARG0, OUT_ARRAY

  // go up stack frames by dereferencing %rbp until we hit stack_top
  rbp_traversal_loop:
    #ifdef DEBUG_PRINTS
    leaq fmt_cur_prev_rbp(%rip), ARG0
    movq CUR_RBP, ARG1
    movq PREV_RBP, ARG2
    call _printf
    #endif

    #define STACK_PTR %r14
    movq PREV_RBP, STACK_PTR
    addq $0x10, STACK_PTR  // ignore prev %rbp and pushed %rip

    // look at quads between PREV_RBP to CUR_RBP
    stack_frame_mem_loop:
      #define STACK_VAL %rbx
      movq (STACK_PTR), STACK_VAL

      #ifdef DEBUG_PRINTS
      leaq fmt_indented_ptr(%rip), ARG0
      movq STACK_VAL, ARG1
      call _printf
      #endif

      // only add to out array if this stack value points inside the global heap
      movq STACK_VAL, ARG0
      call _heap_contains_ptr
      cmpq $0, %rax
      je stack_value_is_not_in_global_heap

        movq OUT_ARRAY, ARG0
        movq STACK_VAL, ARG1
        call _arr_push

      stack_value_is_not_in_global_heap:

      addq $8, STACK_PTR

      // goto stack_frame_mem_loop if STACK_PTR > PREV_RBP
      cmp STACK_PTR, CUR_RBP
      jg stack_frame_mem_loop

    // go up one stack frame
    movq CUR_RBP, PREV_RBP
    movq (CUR_RBP), CUR_RBP

    // goto RBP_traversal_loop if CUR_RBP < stack_top(%rip)
    cmp stack_top(%rip), CUR_RBP
    jle rbp_traversal_loop

  #ifdef DEBUG_PRINTS
  leaq fmt_stack_top(%rip), ARG0
  movq stack_top(%rip), ARG1
  movq stack_top(%rip), ARG2
  call _printf
  #endif

  movq %rbp, %rsp
  popq %rbx
  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %rbp
  ret