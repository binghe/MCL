#ifndef __ERRORS_X
#define __ERRORS_X 1

/*
10/22/96 bill error_too_many_values
--- 4.0 ---
05/12/96  gb  conditionalize on __ERRORS_X to avoid conflict with <errors.h>
--- 3.9 ---
04/10/96  gb  error_memory_full
04/09/96  gb  error_excised_function_call
03/01/96  gb  FPU exceptions
01/22/96  gb  add/rename error_alloc_failed, error_stack_overflow
12/13/95  gb  add error_alloc_fail, error_throw_tag_missing.
11/09/95  gb  in synch with %type-error-types%.
*/

#define error_reg_regnum 0
#define error_udf 1
#define error_udf_call 2
#define error_throw_tag_missing 3
#define error_alloc_failed 4
#define error_stack_overflow 5
#define error_excised_function_call 6
#define error_too_many_values 7
#define error_cant_call 17

#define error_type_error 64
#define type_error(n) (error_type_error+(n))

#define error_object_not_array type_error(0)
#define error_object_not_bignum type_error(1)
#define error_object_not_fixnum type_error(2)
#define error_object_not_character type_error(3)
#define error_object_not_integer type_error(4)
#define error_object_not_list type_error(5)
#define error_object_not_number type_error(6)
#define error_object_not_sequence type_error(7)
#define error_object_not_simple_string type_error(8)
#define error_object_not_simple_vector type_error(9)
#define error_object_not_string type_error(10)
#define error_object_not_symbol type_error(11)
#define error_object_not_macptr type_error(12)
#define error_object_not_real type_error(13)
#define error_object_not_cons type_error(14)
#define error_object_not_unsigned_byte type_error(15)
#define error_object_not_radix type_error(16)
#define error_object_not_float type_error(17)
#define error_object_not_rational type_error(18)
#define error_object_not_ratio type_error(19)
#define error_object_not_short_float type_error(20)
#define error_object_not_double_float type_error(21)
#define error_object_not_complex type_error(22)
#define error_object_not_vector type_error(23)
#define error_object_not_simple_base_string type_error(24)
#define error_object_not_function type_error(25)
#define error_object_not_unsigned_byte_16 type_error(26)
#define error_object_not_unsigned_byte_8 type_error(27)
#define error_object_not_unsigned_byte_32 type_error(28)
#define error_object_not_signed_byte_32 type_error(29)
#define error_object_not_signed_byte_16 type_error(30)
#define error_object_not_signed_byte_8 type_error(31)
#define error_object_not_base_character type_error(32)
#define error_object_not_bit type_error(33)
#define error_object_not_unsigned_byte_24 type_error(34)

#define error_FPU_exception_double 1024
#define error_FPU_exception_short 1025

#define error_memory_full 2048



#endif /* __ERRORS_X */
