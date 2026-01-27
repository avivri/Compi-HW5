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
@.str1 = constant [2 x i8] c"*\00"
@.str2 = constant [2 x i8] c"*\00"

  define i32 @fib(i32) {
  entry:
  %t1 = alloca i32
  store i32 %0, i32* %t1
  %t2 = alloca i32
  store i32 1, i32* %t2
  %t3 = load i32, i32* %t1
  %t4 = add i32 0, 0
  %t5 = icmp eq i32 %t3, %t4
  %t6 = zext i1 %t5 to i32
  %t7 = icmp ne i32 %t6, 0
  br i1 %t7, label %label_3, label %label_2
label_2:
  %t8 = load i32, i32* %t1
  %t9 = add i32 1, 0
  %t10 = icmp eq i32 %t8, %t9
  %t11 = zext i1 %t10 to i32
  store i32 %t11, i32* %t2
  br label %label_3
label_3:
  %t12 = load i32, i32* %t2
  %t13 = icmp ne i32 %t12, 0
  br i1 %t13, label %label_4, label %label_5
label_4:
  %t14 = add i32 1, 0
  ret i32 %t14
label_7:
  br label %label_6
label_5:
  br label %label_6
label_6:
  %t15 = load i32, i32* %t1
  %t16 = add i32 1, 0
  %t17 = sub i32 %t15, %t16
  %t18 = and i32 %t17, 255
  %t19 = call i32 @fib(i32 %t18)
  %t20 = load i32, i32* %t1
  %t21 = add i32 2, 0
  %t22 = sub i32 %t20, %t21
  %t23 = and i32 %t22, 255
  %t24 = call i32 @fib(i32 %t23)
  %t25 = add i32 %t19, %t24
  ret i32 %t25
label_8:
  ret i32 0
  }
  
  define void @main() {
  entry:
  %t26 = alloca i32
  %t27 = add i32 0, 0
  store i32 %t27, i32* %t26
  br label %label_10
label_10:
  %t28 = load i32, i32* %t26
  %t29 = add i32 10, 0
  %t30 = icmp slt i32 %t28, %t29
  %t31 = zext i1 %t30 to i32
  %t32 = icmp ne i32 %t31, 0
  br i1 %t32, label %label_11, label %label_12
label_11:
  %t33 = load i32, i32* %t26
  %t34 = call i32 @fib(i32 %t33)
  call void @printi(i32 %t34)
  %t35 = load i32, i32* %t26
  %t36 = add i32 1, 0
  %t37 = add i32 %t35, %t36
  %t38 = add i32 10, 0
  %t39 = icmp slt i32 %t37, %t38
  %t40 = zext i1 %t39 to i32
  %t41 = icmp ne i32 %t40, 0
  br i1 %t41, label %label_13, label %label_14
label_13:
  %t42 = getelementptr [2 x i8], [2 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t42)
  br label %label_15
label_14:
  br label %label_15
label_15:
  %t43 = load i32, i32* %t26
  %t44 = add i32 1, 0
  %t45 = add i32 %t43, %t44
  %t46 = and i32 %t45, 255
  store i32 %t46, i32* %t26
  br label %label_10
label_12:
  %t47 = getelementptr [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t47)
  ret void
  }
  
