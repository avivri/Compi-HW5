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

  define i32 @fib(i8) {
  entry:
  %t1 = alloca i8
  store i8 %0, i8* %t1
  %t2 = alloca i1
  store i1 1, i1* %t2
  %t3 = load i8, i8* %t1
  %t4 = add i32 0, 0
  %t5 = zext i8 %t3 to i32
  %t6 = icmp eq i32 %t5, %t4
  br i1 %t6, label %label_3, label %label_2
label_2:
  %t7 = load i8, i8* %t1
  %t8 = add i32 1, 0
  %t9 = zext i8 %t7 to i32
  %t10 = icmp eq i32 %t9, %t8
  store i1 %t10, i1* %t2
  br label %label_3
label_3:
  %t11 = load i1, i1* %t2
  br i1 %t11, label %label_4, label %label_5
label_4:
  %t12 = add i32 1, 0
  ret i32 %t12
label_5:
  br label %label_6
label_6:
  %t13 = load i8, i8* %t1
  %t14 = add i8 1, 0
  %t15 = sub i8 %t13, %t14
  %t16 = call i32 @fib(i8 %t15)
  %t17 = load i8, i8* %t1
  %t18 = add i8 2, 0
  %t19 = sub i8 %t17, %t18
  %t20 = call i32 @fib(i8 %t19)
  %t21 = add i32 %t16, %t20
  ret i32 %t21
  }
  
  define void @main() {
  entry:
  %t22 = alloca i8
  %t23 = add i8 0, 0
  store i8 %t23, i8* %t22
  }
  
