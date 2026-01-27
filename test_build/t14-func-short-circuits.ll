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

  define i32 @f1() {
  entry:
  %t1 = getelementptr [4 x i8], [4 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t1)
  %t2 = add i32 1, 0
  ret i32 %t2
label_2:
  ret i32 0
  }
  
  define i32 @f2() {
  entry:
  %t3 = getelementptr [4 x i8], [4 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t3)
  %t4 = add i32 0, 0
  ret i32 %t4
label_4:
  ret i32 0
  }
  
  define void @main() {
  entry:
  %t5 = alloca i32
  store i32 1, i32* %t5
  %t6 = call i32 @f1()
  %t7 = icmp ne i32 %t6, 0
  br i1 %t7, label %label_7, label %label_6
label_6:
  %t8 = call i32 @f2()
  store i32 %t8, i32* %t5
  br label %label_7
label_7:
  %t9 = load i32, i32* %t5
  %t10 = icmp ne i32 %t9, 0
  br i1 %t10, label %label_8, label %label_9
label_8:
  %t11 = alloca i32
  store i32 0, i32* %t11
  br label %label_10
label_9:
  br label %label_10
label_10:
  %t12 = alloca i32
  store i32 1, i32* %t12
  %t13 = call i32 @f2()
  %t14 = icmp ne i32 %t13, 0
  br i1 %t14, label %label_12, label %label_11
label_11:
  %t15 = call i32 @f1()
  store i32 %t15, i32* %t12
  br label %label_12
label_12:
  %t16 = load i32, i32* %t12
  %t17 = icmp ne i32 %t16, 0
  br i1 %t17, label %label_13, label %label_14
label_13:
  %t18 = alloca i32
  store i32 0, i32* %t18
  br label %label_15
label_14:
  br label %label_15
label_15:
  %t19 = alloca i32
  store i32 1, i32* %t19
  %t20 = call i32 @f2()
  %t21 = xor i32 %t20, 1
  %t22 = icmp ne i32 %t21, 0
  br i1 %t22, label %label_17, label %label_16
label_16:
  %t23 = call i32 @f1()
  store i32 %t23, i32* %t19
  br label %label_17
label_17:
  %t24 = load i32, i32* %t19
  %t25 = icmp ne i32 %t24, 0
  br i1 %t25, label %label_18, label %label_19
label_18:
  %t26 = alloca i32
  store i32 0, i32* %t26
  br label %label_20
label_19:
  br label %label_20
label_20:
  %t27 = call i32 @f1()
  %t28 = alloca i32
  store i32 0, i32* %t28
  %t29 = icmp ne i32 %t27, 0
  br i1 %t29, label %label_21, label %label_22
label_21:
  %t30 = call i32 @f2()
  store i32 %t30, i32* %t28
  br label %label_22
label_22:
  %t31 = load i32, i32* %t28
  %t32 = icmp ne i32 %t31, 0
  br i1 %t32, label %label_23, label %label_24
label_23:
  %t33 = alloca i32
  store i32 0, i32* %t33
  br label %label_25
label_24:
  br label %label_25
label_25:
  %t34 = call i32 @f2()
  %t35 = alloca i32
  store i32 0, i32* %t35
  %t36 = icmp ne i32 %t34, 0
  br i1 %t36, label %label_26, label %label_27
label_26:
  %t37 = call i32 @f1()
  store i32 %t37, i32* %t35
  br label %label_27
label_27:
  %t38 = load i32, i32* %t35
  %t39 = icmp ne i32 %t38, 0
  br i1 %t39, label %label_28, label %label_29
label_28:
  %t40 = alloca i32
  store i32 0, i32* %t40
  br label %label_30
label_29:
  br label %label_30
label_30:
  %t41 = call i32 @f2()
  %t42 = xor i32 %t41, 1
  %t43 = alloca i32
  store i32 0, i32* %t43
  %t44 = icmp ne i32 %t42, 0
  br i1 %t44, label %label_31, label %label_32
label_31:
  %t45 = call i32 @f1()
  store i32 %t45, i32* %t43
  br label %label_32
label_32:
  %t46 = load i32, i32* %t43
  %t47 = icmp ne i32 %t46, 0
  br i1 %t47, label %label_33, label %label_34
label_33:
  %t48 = alloca i32
  store i32 0, i32* %t48
  br label %label_35
label_34:
  br label %label_35
label_35:
  %t49 = alloca i32
  %t50 = add i32 0, 0
  store i32 %t50, i32* %t49
  br label %label_36
label_36:
  %t51 = call i32 @f1()
  %t52 = alloca i32
  store i32 0, i32* %t52
  %t53 = icmp ne i32 %t51, 0
  br i1 %t53, label %label_39, label %label_40
label_39:
  %t54 = load i32, i32* %t49
  %t55 = add i32 2, 0
  %t56 = icmp slt i32 %t54, %t55
  %t57 = zext i1 %t56 to i32
  store i32 %t57, i32* %t52
  br label %label_40
label_40:
  %t58 = load i32, i32* %t52
  %t59 = icmp ne i32 %t58, 0
  br i1 %t59, label %label_37, label %label_38
label_37:
  %t60 = load i32, i32* %t49
  %t61 = add i32 2, 0
  %t62 = add i32 %t60, %t61
  store i32 %t62, i32* %t49
  %t63 = load i32, i32* %t49
  call void @printi(i32 %t63)
  br label %label_36
label_38:
  %t64 = add i32 0, 0
  store i32 %t64, i32* %t49
  br label %label_41
label_41:
  %t65 = alloca i32
  store i32 1, i32* %t65
  %t66 = call i32 @f2()
  %t67 = icmp ne i32 %t66, 0
  br i1 %t67, label %label_45, label %label_44
label_44:
  %t68 = load i32, i32* %t49
  %t69 = add i32 2, 0
  %t70 = icmp slt i32 %t68, %t69
  %t71 = zext i1 %t70 to i32
  store i32 %t71, i32* %t65
  br label %label_45
label_45:
  %t72 = load i32, i32* %t65
  %t73 = icmp ne i32 %t72, 0
  br i1 %t73, label %label_42, label %label_43
label_42:
  %t74 = load i32, i32* %t49
  %t75 = add i32 3, 0
  %t76 = add i32 %t74, %t75
  store i32 %t76, i32* %t49
  %t77 = load i32, i32* %t49
  call void @printi(i32 %t77)
  br label %label_41
label_43:
  ret void
  }
  
