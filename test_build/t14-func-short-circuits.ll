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
@.str1 = constant [4 x i8] c"f1.\00"
@.str2 = constant [4 x i8] c"f2.\00"

  define i1 @f1() {
  entry:
  %t1 = getelementptr [4 x i8], [4 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t1)
  %t2 = add i1 1, 0
  ret i1 %t2
  }
  
  define i1 @f2() {
  entry:
  %t3 = getelementptr [4 x i8], [4 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t3)
  }
  
  define void @main() {
  entry:
  %t4 = alloca i1
  store i1 1, i1* %t4
  %t5 = call i1 @f1()
  br i1 %t5, label %label_5, label %label_4
label_4:
  %t6 = call i1 @f2()
  store i1 %t6, i1* %t4
  br label %label_5
label_5:
  %t7 = load i1, i1* %t4
  br i1 %t7, label %label_6, label %label_7
label_6:
  %t8 = alloca i32
  store i32 0, i32* %t8
  br label %label_8
label_7:
  br label %label_8
label_8:
  %t9 = alloca i1
  store i1 1, i1* %t9
  %t10 = call i1 @f2()
  br i1 %t10, label %label_10, label %label_9
label_9:
  %t11 = call i1 @f1()
  store i1 %t11, i1* %t9
  br label %label_10
label_10:
  %t12 = load i1, i1* %t9
  br i1 %t12, label %label_11, label %label_12
label_11:
  %t13 = alloca i32
  store i32 0, i32* %t13
  br label %label_13
label_12:
  br label %label_13
label_13:
  %t14 = alloca i1
  store i1 1, i1* %t14
  %t15 = call i1 @f2()
  %t16 = xor i1 %t15, 1
  br i1 %t16, label %label_15, label %label_14
label_14:
  %t17 = call i1 @f1()
  store i1 %t17, i1* %t14
  br label %label_15
label_15:
  %t18 = load i1, i1* %t14
  br i1 %t18, label %label_16, label %label_17
label_16:
  %t19 = alloca i32
  store i32 0, i32* %t19
  br label %label_18
label_17:
  br label %label_18
label_18:
  %t20 = call i1 @f1()
  %t21 = alloca i1
  store i1 0, i1* %t21
  br i1 %t20, label %label_19, label %label_20
label_19:
  %t22 = call i1 @f2()
  store i1 %t22, i1* %t21
  br label %label_20
label_20:
  %t23 = load i1, i1* %t21
  br i1 %t23, label %label_21, label %label_22
label_21:
  %t24 = alloca i32
  store i32 0, i32* %t24
  br label %label_23
label_22:
  br label %label_23
label_23:
  %t25 = call i1 @f2()
  %t26 = alloca i1
  store i1 0, i1* %t26
  br i1 %t25, label %label_24, label %label_25
label_24:
  %t27 = call i1 @f1()
  store i1 %t27, i1* %t26
  br label %label_25
label_25:
  %t28 = load i1, i1* %t26
  br i1 %t28, label %label_26, label %label_27
label_26:
  %t29 = alloca i32
  store i32 0, i32* %t29
  br label %label_28
label_27:
  br label %label_28
label_28:
  %t30 = call i1 @f2()
  %t31 = xor i1 %t30, 1
  %t32 = alloca i1
  store i1 0, i1* %t32
  br i1 %t31, label %label_29, label %label_30
label_29:
  %t33 = call i1 @f1()
  store i1 %t33, i1* %t32
  br label %label_30
label_30:
  %t34 = load i1, i1* %t32
  br i1 %t34, label %label_31, label %label_32
label_31:
  %t35 = alloca i32
  store i32 0, i32* %t35
  br label %label_33
label_32:
  br label %label_33
label_33:
  %t36 = alloca i32
  %t37 = add i32 0, 0
  store i32 %t37, i32* %t36
  br label %label_34
label_34:
  %t38 = call i1 @f1()
  %t39 = alloca i1
  store i1 0, i1* %t39
  br i1 %t38, label %label_37, label %label_38
label_37:
  %t40 = load i32, i32* %t36
  %t41 = add i32 2, 0
  %t42 = icmp slt i32 %t40, %t41
  store i1 %t42, i1* %t39
  br label %label_38
label_38:
  %t43 = load i1, i1* %t39
  br i1 %t43, label %label_35, label %label_36
label_35:
  %t44 = load i32, i32* %t36
  %t45 = add i32 2, 0
  %t46 = add i32 %t44, %t45
  store i32 %t46, i32* %t36
  %t47 = load i32, i32* %t36
  call void @printi(i32 %t47)
  br label %label_34
label_36:
  %t48 = add i32 0, 0
  store i32 %t48, i32* %t36
  br label %label_39
label_39:
  %t49 = alloca i1
  store i1 1, i1* %t49
  %t50 = call i1 @f2()
  br i1 %t50, label %label_43, label %label_42
label_42:
  %t51 = load i32, i32* %t36
  %t52 = add i32 2, 0
  %t53 = icmp slt i32 %t51, %t52
  store i1 %t53, i1* %t49
  br label %label_43
label_43:
  %t54 = load i1, i1* %t49
  br i1 %t54, label %label_40, label %label_41
label_40:
  %t55 = load i32, i32* %t36
  %t56 = add i32 3, 0
  %t57 = add i32 %t55, %t56
  store i32 %t57, i32* %t36
  %t58 = load i32, i32* %t36
  call void @printi(i32 %t58)
  br label %label_39
label_41:
  ret void
  }
  
