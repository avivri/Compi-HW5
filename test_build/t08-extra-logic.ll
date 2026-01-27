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
@.str1 = constant [7 x i8] c"equal!\00"
@.str2 = constant [17 x i8] c"shouldn't happen\00"
@.str3 = constant [9 x i8] c"smaller!\00"
@.str4 = constant [17 x i8] c"shouldn't happen\00"
@.str5 = constant [20 x i8] c"short circuit works\00"
@.str6 = constant [32 x i8] c"wrong but at least didn't crash\00"
@.str7 = constant [5 x i8] c"good\00"

  define void @main() {
  entry:
  %t1 = add i32 100, 0
  %t2 = add i32 100, 0
  %t3 = icmp eq i32 %t1, %t2
  %t4 = zext i1 %t3 to i32
  %t5 = icmp ne i32 %t4, 0
  br i1 %t5, label %label_2, label %label_3
label_2:
  %t6 = getelementptr [7 x i8], [7 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t6)
  br label %label_4
label_3:
  %t7 = getelementptr [17 x i8], [17 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t7)
  br label %label_4
label_4:
  %t8 = add i32 5, 0
  %t9 = add i32 6, 0
  %t10 = icmp slt i32 %t8, %t9
  %t11 = zext i1 %t10 to i32
  %t12 = icmp ne i32 %t11, 0
  br i1 %t12, label %label_5, label %label_6
label_5:
  %t13 = getelementptr [9 x i8], [9 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t13)
  br label %label_7
label_6:
  %t14 = getelementptr [17 x i8], [17 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t14)
  br label %label_7
label_7:
  %t15 = alloca i32
  store i32 1, i32* %t15
  %t16 = add i32 4, 0
  %t17 = add i32 5, 0
  %t18 = icmp sle i32 %t16, %t17
  %t19 = zext i1 %t18 to i32
  %t20 = icmp ne i32 %t19, 0
  br i1 %t20, label %label_9, label %label_8
label_8:
  %t21 = add i32 8, 0
  %t22 = add i32 0, 0
  %t23 = icmp eq i32 %t22, 0
  br i1 %t23, label %label_11, label %label_10
label_11:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_10:
  %t24 = sdiv i32 %t21, %t22
  %t25 = add i32 10, 0
  %t26 = icmp slt i32 %t24, %t25
  %t27 = zext i1 %t26 to i32
  store i32 %t27, i32* %t15
  br label %label_9
label_9:
  %t28 = load i32, i32* %t15
  %t29 = icmp ne i32 %t28, 0
  br i1 %t29, label %label_12, label %label_13
label_12:
  %t30 = getelementptr [20 x i8], [20 x i8]* @.str5, i32 0, i32 0
  call void @print(i8* %t30)
  br label %label_14
label_13:
  br label %label_14
label_14:
  %t31 = add i32 5, 0
  %t32 = add i32 100, 0
  %t33 = icmp sgt i32 %t31, %t32
  %t34 = zext i1 %t33 to i32
  %t35 = alloca i32
  store i32 0, i32* %t35
  %t36 = icmp ne i32 %t34, 0
  br i1 %t36, label %label_15, label %label_16
label_15:
  %t37 = add i32 6, 0
  %t38 = add i32 0, 0
  %t39 = icmp eq i32 %t38, 0
  br i1 %t39, label %label_18, label %label_17
label_18:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_17:
  %t40 = udiv i32 %t37, %t38
  %t41 = and i32 %t40, 255
  %t42 = add i32 1, 0
  %t43 = icmp ne i32 %t41, %t42
  %t44 = zext i1 %t43 to i32
  store i32 %t44, i32* %t35
  br label %label_16
label_16:
  %t45 = load i32, i32* %t35
  %t46 = icmp ne i32 %t45, 0
  br i1 %t46, label %label_19, label %label_20
label_19:
  %t47 = getelementptr [32 x i8], [32 x i8]* @.str6, i32 0, i32 0
  call void @print(i8* %t47)
  br label %label_21
label_20:
  br label %label_21
label_21:
  %t48 = add i32 1, 0
  %t49 = add i32 1, 0
  %t50 = icmp ne i32 %t48, %t49
  %t51 = zext i1 %t50 to i32
  %t52 = xor i32 %t51, 1
  %t53 = alloca i32
  store i32 0, i32* %t53
  %t54 = icmp ne i32 %t52, 0
  br i1 %t54, label %label_22, label %label_23
label_22:
  %t55 = add i32 8, 0
  %t56 = add i32 2, 0
  %t57 = icmp sge i32 %t55, %t56
  %t58 = zext i1 %t57 to i32
  store i32 %t58, i32* %t53
  br label %label_23
label_23:
  %t59 = load i32, i32* %t53
  %t60 = icmp ne i32 %t59, 0
  br i1 %t60, label %label_24, label %label_25
label_24:
  %t61 = getelementptr [5 x i8], [5 x i8]* @.str7, i32 0, i32 0
  call void @print(i8* %t61)
  br label %label_26
label_25:
  br label %label_26
label_26:
  ret void
  }
  
