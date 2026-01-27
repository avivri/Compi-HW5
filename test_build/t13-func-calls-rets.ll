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
@.str1 = constant [5 x i8] c"true\00"
@.str2 = constant [6 x i8] c"false\00"
@.str3 = constant [5 x i8] c"true\00"
@.str4 = constant [6 x i8] c"false\00"
@.str5 = constant [5 x i8] c"true\00"
@.str6 = constant [6 x i8] c"false\00"

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
label_2:
  ret i32 0
  }
  
  define i32 @func2() {
  entry:
  %t8 = add i32 100, 0
  ret i32 %t8
label_4:
  ret i32 0
  }
  
  define i32 @func3() {
  entry:
  %t9 = add i32 1, 0
  ret i32 %t9
label_6:
  ret i32 0
  }
  
  define i32 @func4() {
  entry:
  %t10 = add i32 67, 0
  ret i32 %t10
label_8:
  ret i32 0
  }
  
  define i32 @func5(i32) {
  entry:
  %t11 = alloca i32
  store i32 %0, i32* %t11
  %t12 = alloca i32
  store i32 1, i32* %t12
  %t13 = load i32, i32* %t11
  %t14 = icmp ne i32 %t13, 0
  br i1 %t14, label %label_11, label %label_10
label_10:
  %t15 = load i32, i32* %t11
  %t16 = xor i32 %t15, 1
  store i32 %t16, i32* %t12
  br label %label_11
label_11:
  %t17 = load i32, i32* %t12
  ret i32 %t17
label_12:
  ret i32 0
  }
  
  define i32 @func6(i32) {
  entry:
  %t18 = alloca i32
  store i32 %0, i32* %t18
  %t19 = load i32, i32* %t18
  %t20 = add i32 3, 0
  %t21 = add i32 %t19, %t20
  ret i32 %t21
label_14:
  ret i32 0
  }
  
  define i32 @func7(i32, i32) {
  entry:
  %t22 = alloca i32
  store i32 %0, i32* %t22
  %t23 = alloca i32
  store i32 %1, i32* %t23
  %t24 = load i32, i32* %t22
  %t25 = load i32, i32* %t23
  %t26 = icmp sle i32 %t24, %t25
  %t27 = zext i1 %t26 to i32
  %t28 = alloca i32
  store i32 0, i32* %t28
  %t29 = icmp ne i32 %t27, 0
  br i1 %t29, label %label_16, label %label_17
label_16:
  %t30 = load i32, i32* %t22
  %t31 = load i32, i32* %t23
  %t32 = icmp ne i32 %t30, %t31
  %t33 = zext i1 %t32 to i32
  store i32 %t33, i32* %t28
  br label %label_17
label_17:
  %t34 = load i32, i32* %t28
  ret i32 %t34
label_18:
  ret i32 0
  }
  
  define void @main() {
  entry:
  %t35 = call i32 @func1()
  call void @printi(i32 %t35)
  %t36 = call i32 @func2()
  call void @printi(i32 %t36)
  %t37 = call i32 @func3()
  %t38 = icmp ne i32 %t37, 0
  br i1 %t38, label %label_20, label %label_21
label_20:
  %t39 = getelementptr [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t39)
  br label %label_22
label_21:
  %t40 = getelementptr [6 x i8], [6 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t40)
  br label %label_22
label_22:
  %t41 = call i32 @func4()
  call void @printi(i32 %t41)
  %t42 = add i32 1, 0
  %t43 = call i32 @func5(i32 %t42)
  %t44 = icmp ne i32 %t43, 0
  br i1 %t44, label %label_23, label %label_24
label_23:
  %t45 = getelementptr [5 x i8], [5 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t45)
  br label %label_25
label_24:
  %t46 = getelementptr [6 x i8], [6 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t46)
  br label %label_25
label_25:
  %t47 = add i32 2, 0
  %t48 = call i32 @func6(i32 %t47)
  call void @printi(i32 %t48)
  %t49 = add i32 5, 0
  %t50 = add i32 100, 0
  %t51 = call i32 @func7(i32 %t49, i32 %t50)
  %t52 = icmp ne i32 %t51, 0
  br i1 %t52, label %label_26, label %label_27
label_26:
  %t53 = getelementptr [5 x i8], [5 x i8]* @.str5, i32 0, i32 0
  call void @print(i8* %t53)
  br label %label_28
label_27:
  %t54 = getelementptr [6 x i8], [6 x i8]* @.str6, i32 0, i32 0
  call void @print(i8* %t54)
  br label %label_28
label_28:
  ret void
  }
  
