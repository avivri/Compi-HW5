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
  %t3 = alloca i8
  %t4 = add i8 1, 0
  store i8 %t4, i8* %t3
  br label %label_2
label_2:
  %t5 = load i32, i32* %t1
  %t6 = add i32 12, 0
  %t7 = icmp slt i32 %t5, %t6
  br i1 %t7, label %label_3, label %label_4
label_3:
  %t8 = add i8 1, 0
  store i8 %t8, i8* %t3
  br label %label_5
label_5:
  %t9 = load i8, i8* %t3
  %t10 = add i32 12, 0
  %t11 = zext i8 %t9 to i32
  %t12 = icmp slt i32 %t11, %t10
  br i1 %t12, label %label_6, label %label_7
label_6:
  %t13 = load i32, i32* %t1
  %t14 = load i8, i8* %t3
  %t15 = zext i8 %t14 to i32
  %t16 = mul i32 %t13, %t15
  %t17 = load i32, i32* %t1
  %t18 = load i8, i8* %t3
  %t19 = zext i8 %t18 to i32
  %t20 = mul i32 %t17, %t19
  %t21 = add i32 10, 0
  %t22 = icmp eq i32 %t21, 0
  br i1 %t22, label %label_9, label %label_8
label_9:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_8:
  %t23 = sdiv i32 %t20, %t21
  %t24 = sub i32 %t16, %t23
  %t25 = add i32 10, 0
  %t26 = mul i32 %t24, %t25
  %t27 = add i32 0, 0
  %t28 = icmp eq i32 %t26, %t27
  br i1 %t28, label %label_10, label %label_11
label_10:
  br label %label_7
label_11:
  br label %label_12
label_12:
  %t29 = alloca i32
  %t30 = add i32 0, 0
  store i32 %t30, i32* %t29
  br label %label_13
label_13:
  %t31 = load i32, i32* %t29
  %t32 = load i32, i32* %t1
  %t33 = load i8, i8* %t3
  %t34 = zext i8 %t33 to i32
  %t35 = mul i32 %t32, %t34
  %t36 = icmp slt i32 %t31, %t35
  br i1 %t36, label %label_14, label %label_15
label_14:
  %t37 = load i32, i32* %t29
  %t38 = add i32 1, 0
  %t39 = add i32 %t37, %t38
  store i32 %t39, i32* %t29
  %t40 = load i32, i32* %t29
  %t41 = add i32 2, 0
  %t42 = icmp eq i32 %t41, 0
  br i1 %t42, label %label_17, label %label_16
label_17:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_16:
  %t43 = sdiv i32 %t40, %t41
  %t44 = add i32 0, 0
  %t45 = icmp eq i32 %t43, %t44
  br i1 %t45, label %label_18, label %label_19
label_18:
  %t46 = getelementptr [6 x i8], [6 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t46)
  br label %label_13
label_19:
  br label %label_20
label_20:
  %t47 = getelementptr [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t47)
  %t48 = load i32, i32* %t29
  %t49 = load i32, i32* %t29
  %t50 = add i32 2, 0
  %t51 = icmp eq i32 %t50, 0
  br i1 %t51, label %label_22, label %label_21
label_22:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_21:
  %t52 = sdiv i32 %t49, %t50
  %t53 = sub i32 %t48, %t52
  %t54 = add i32 2, 0
  %t55 = mul i32 %t53, %t54
  %t56 = add i32 0, 0
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %label_23, label %label_24
label_23:
  %t58 = getelementptr [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t58)
  br label %label_13
label_24:
  br label %label_25
label_25:
  br label %label_13
label_15:
  %t59 = load i8, i8* %t3
  %t60 = add i8 1, 0
  %t61 = add i8 %t59, %t60
  store i8 %t61, i8* %t3
  br label %label_5
label_7:
  %t62 = load i32, i32* %t1
  %t63 = add i32 1, 0
  %t64 = add i32 %t62, %t63
  store i32 %t64, i32* %t1
  br label %label_2
label_4:
  ret void
  }
  
