#include <stdint.h>

void module_variable_get_a1(int32_t *var);
void module_variable_set_a1(int32_t *var);

void module_variable_get_a2(int32_t *var);

void module_variable_get_a3(int32_t *var);
void module_variable_set_a3(int32_t *var);

void module_variable_get_arr1(int32_t *var);
void module_variable_set_arr1(int32_t *var);

void module_variable_get_arr2(int32_t *var);

void module_variable_get_arr3_size(int32_t *dim1);
void module_variable_get_arr3(int32_t *dim1, int32_t *var);
void module_variable_set_arr3(int32_t *dim1, int32_t *var);

// characters

void module_variable_get_str1(char *var);
void module_variable_set_str1(int32_t *len1, char *var);

void module_variable_get_str2_len(int32_t *len1);
void module_variable_get_str2(int32_t *len1, char *var);
void module_variable_set_str2(int32_t *len1, char *var);

void module_variable_get_str4_size(int32_t *dim1);
void module_variable_get_str4(int32_t *len1, int32_t *dim1, char *var);
void module_variable_set_str4(int32_t *len1, int32_t *dim1, char *var);


