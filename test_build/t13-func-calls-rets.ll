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

  define i32 @func1() {
  entry:
  %t1 = add i32 1, 0
  %t2 = add i32 2, 0
  %t3 = add i32 %t1, %t2
  %t4 = add i32 3, 0
  %t5 = mul i32 %t3, %t4
  %t6 = add i32 4, 0
  %t7 = add i32 %t5, %t6
  ret i32 %t7
  }
  
  define i8 @func2() {
  entry:
  %t8 = add i8 100, 0
  ret i8 %t8
  }
  
  define i1 @func3() {
  entry:
  %t9 = add i1 1, 0
  ret i1 %t9
  }
  
  define i32 @func4() {
  entry:
  %t10 = add i8 67, 0
  %t11 = zext i8 %t10 to i32
  ret i32 %t11
  }
  
  define i1 @func5(i1) {
  entry:
  %t12 = alloca i1
  store i1 %0, i1* %t12
  %t13 = alloca i1
  store i1 1, i1* %t13
  %t14 = load i1, i1* %t12
  br i1 %t14, label %label_7, label %label_6
label_6:
  %t15 = load i1, i1* %t12
  %t16 = xor i1 %t15, 1
  store i1 %t16, i1* %t13
  br label %label_7
label_7:
  %t17 = load i1, i1* %t13
  ret i1 %t17
  }
  
  define i32 @func6(i8) {
  entry:
  %t18 = alloca i8
  store i8 %0, i8* %t18
  %t19 = load i8, i8* %t18
  %t20 = add i32 3, 0
  %t21 = zext i8 %t19 to i32
  %t22 = add i32 %t21, %t20
  ret i32 %t22
  }
  
  define i1 @func7(i8, i32) {
  entry:
  %t23 = alloca i8
  store i8 %0, i8* %t23
  %t24 = alloca i32
  store i32 %1, i32* %t24
  %t25 = load i8, i8* %t23
  %t26 = load i32, i32* %t24
  %t27 = zext i8 %t25 to i32
  %t28 = icmp sle i32 %t27, %t26
  %t29 = alloca i1
  store i1 0, i1* %t29
  br i1 %t28, label %label_10, label %label_11
label_10:
  %t30 = load i8, i8* %t23
  %t31 = load i32, i32* %t24
  %t32 = zext i8 %t30 to i32
  %t33 = icmp ne i32 %t32, %t31
  store i1 %t33, i1* %t29
  br label %label_11
label_11:
  %t34 = load i1, i1* %t29
  ret i1 %t34
  }
  
  define void @main() {
  entry:
  %t35 = call i32 @func1()
  call void @printi(i32 %t35)
  }
  
