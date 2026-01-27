declare i32 @printf(i8*, ...)
declare void @exit(i32)
@.int_specifier = constant [4 x i8] c"%d\0A\00"
@.str_specifier = constant [4 x i8] c"%s\0A\00"
define void @printi(i32) {
  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.int_specifier, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %spec_ptr, i32 %0)
  ret void
}
define void @print(i8*) {
  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.str_specifier, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %spec_ptr, i8* %0)
  ret void
}
@.str_div_err = constant [23 x i8] c"Error division by zero\00"

  define void @main() {
  entry:
  %t1 = alloca i32
  %t2 = add i32 5, 0
  store i32 %t2, i32* %t1
  %t3 = alloca i32
  %t4 = add i32 5, 0
  store i32 %t4, i32* %t3
  %t5 = alloca i32
  %t6 = add i32 2, 0
  %t7 = load i32, i32* %t1
  %t8 = load i32, i32* %t3
  %t9 = sub i32 %t7, %t8
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %label_3, label %label_2
label_3:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_2:
  %t11 = sdiv i32 %t6, %t9
  store i32 %t11, i32* %t5
  ret void
  }
  
