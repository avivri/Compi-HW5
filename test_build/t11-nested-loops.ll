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
@.str1 = constant [6 x i8] c"FIRE!\00"
@.str2 = constant [2 x i8] c"*\00"
@.str3 = constant [2 x i8] c"-\00"

  define void @main() {
  entry:
  %t1 = alloca i32
  %t2 = add i32 1, 0
  store i32 %t2, i32* %t1
  %t3 = alloca i32
  %t4 = add i32 1, 0
  store i32 %t4, i32* %t3
  br label %label_2
label_2:
  %t5 = load i32, i32* %t1
  %t6 = add i32 12, 0
  %t7 = icmp slt i32 %t5, %t6
  %t8 = zext i1 %t7 to i32
  %t9 = icmp ne i32 %t8, 0
  br i1 %t9, label %label_3, label %label_4
label_3:
  %t10 = add i32 1, 0
  store i32 %t10, i32* %t3
  br label %label_5
label_5:
  %t11 = load i32, i32* %t3
  %t12 = add i32 12, 0
  %t13 = icmp slt i32 %t11, %t12
  %t14 = zext i1 %t13 to i32
  %t15 = icmp ne i32 %t14, 0
  br i1 %t15, label %label_6, label %label_7
label_6:
  %t16 = load i32, i32* %t1
  %t17 = load i32, i32* %t3
  %t18 = mul i32 %t16, %t17
  %t19 = load i32, i32* %t1
  %t20 = load i32, i32* %t3
  %t21 = mul i32 %t19, %t20
  %t22 = add i32 10, 0
  %t23 = icmp eq i32 %t22, 0
  br i1 %t23, label %label_9, label %label_8
label_9:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_8:
  %t24 = sdiv i32 %t21, %t22
  %t25 = sub i32 %t18, %t24
  %t26 = add i32 10, 0
  %t27 = mul i32 %t25, %t26
  %t28 = add i32 0, 0
  %t29 = icmp eq i32 %t27, %t28
  %t30 = zext i1 %t29 to i32
  %t31 = icmp ne i32 %t30, 0
  br i1 %t31, label %label_10, label %label_11
label_10:
  br label %label_7
label_13:
  br label %label_12
label_11:
  br label %label_12
label_12:
  %t32 = alloca i32
  %t33 = add i32 0, 0
  store i32 %t33, i32* %t32
  br label %label_14
label_14:
  %t34 = load i32, i32* %t32
  %t35 = load i32, i32* %t1
  %t36 = load i32, i32* %t3
  %t37 = mul i32 %t35, %t36
  %t38 = icmp slt i32 %t34, %t37
  %t39 = zext i1 %t38 to i32
  %t40 = icmp ne i32 %t39, 0
  br i1 %t40, label %label_15, label %label_16
label_15:
  %t41 = load i32, i32* %t32
  %t42 = add i32 1, 0
  %t43 = add i32 %t41, %t42
  store i32 %t43, i32* %t32
  %t44 = load i32, i32* %t32
  %t45 = add i32 2, 0
  %t46 = icmp eq i32 %t45, 0
  br i1 %t46, label %label_18, label %label_17
label_18:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_17:
  %t47 = sdiv i32 %t44, %t45
  %t48 = add i32 0, 0
  %t49 = icmp eq i32 %t47, %t48
  %t50 = zext i1 %t49 to i32
  %t51 = icmp ne i32 %t50, 0
  br i1 %t51, label %label_19, label %label_20
label_19:
  %t52 = getelementptr [6 x i8], [6 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t52)
  br label %label_14
label_22:
  br label %label_21
label_20:
  br label %label_21
label_21:
  %t53 = getelementptr [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t53)
  %t54 = load i32, i32* %t32
  %t55 = load i32, i32* %t32
  %t56 = add i32 2, 0
  %t57 = icmp eq i32 %t56, 0
  br i1 %t57, label %label_24, label %label_23
label_24:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_23:
  %t58 = sdiv i32 %t55, %t56
  %t59 = sub i32 %t54, %t58
  %t60 = add i32 2, 0
  %t61 = mul i32 %t59, %t60
  %t62 = add i32 0, 0
  %t63 = icmp eq i32 %t61, %t62
  %t64 = zext i1 %t63 to i32
  %t65 = icmp ne i32 %t64, 0
  br i1 %t65, label %label_25, label %label_26
label_25:
  %t66 = getelementptr [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t66)
  br label %label_14
label_28:
  br label %label_27
label_26:
  br label %label_27
label_27:
  br label %label_14
label_16:
  %t67 = load i32, i32* %t3
  %t68 = add i32 1, 0
  %t69 = add i32 %t67, %t68
  %t70 = and i32 %t69, 255
  store i32 %t70, i32* %t3
  br label %label_5
label_7:
  %t71 = load i32, i32* %t1
  %t72 = add i32 1, 0
  %t73 = add i32 %t71, %t72
  store i32 %t73, i32* %t1
  br label %label_2
label_4:
  ret void
  }
  
