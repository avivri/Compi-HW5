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
  %t2 = add i8 100, 0
  %t3 = zext i8 %t2 to i32
  %t4 = icmp eq i32 %t1, %t3
  br i1 %t4, label %label_2, label %label_3
label_2:
  %t5 = getelementptr [7 x i8], [7 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t5)
  br label %label_4
label_3:
  %t6 = getelementptr [17 x i8], [17 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t6)
  br label %label_4
label_4:
  %t7 = add i32 5, 0
  %t8 = add i8 6, 0
  %t9 = zext i8 %t8 to i32
  %t10 = icmp slt i32 %t7, %t9
  br i1 %t10, label %label_5, label %label_6
label_5:
  %t11 = getelementptr [9 x i8], [9 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t11)
  br label %label_7
label_6:
  %t12 = getelementptr [17 x i8], [17 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t12)
  br label %label_7
label_7:
  %t13 = alloca i1
  store i1 1, i1* %t13
  %t14 = add i8 4, 0
  %t15 = add i32 5, 0
  %t16 = zext i8 %t14 to i32
  %t17 = icmp sle i32 %t16, %t15
  br i1 %t17, label %label_9, label %label_8
label_8:
  %t18 = add i32 8, 0
  %t19 = add i32 0, 0
  %t20 = icmp eq i32 %t19, 0
  br i1 %t20, label %label_11, label %label_10
label_11:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_10:
  %t21 = sdiv i32 %t18, %t19
  %t22 = add i32 10, 0
  %t23 = icmp slt i32 %t21, %t22
  store i1 %t23, i1* %t13
  br label %label_9
label_9:
  %t24 = load i1, i1* %t13
  br i1 %t24, label %label_12, label %label_13
label_12:
  %t25 = getelementptr [20 x i8], [20 x i8]* @.str5, i32 0, i32 0
  call void @print(i8* %t25)
  br label %label_14
label_13:
  br label %label_14
label_14:
  %t26 = add i32 5, 0
  %t27 = add i8 100, 0
  %t28 = zext i8 %t27 to i32
  %t29 = icmp sgt i32 %t26, %t28
  %t30 = alloca i1
  store i1 0, i1* %t30
  br i1 %t29, label %label_15, label %label_16
label_15:
  %t31 = add i8 6, 0
  %t32 = add i8 0, 0
  %t33 = icmp eq i8 %t32, 0
  br i1 %t33, label %label_18, label %label_17
label_18:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_17:
  %t34 = udiv i8 %t31, %t32
  %t35 = add i32 1, 0
  %t36 = zext i8 %t34 to i32
  %t37 = icmp ne i32 %t36, %t35
  store i1 %t37, i1* %t30
  br label %label_16
label_16:
  %t38 = load i1, i1* %t30
  br i1 %t38, label %label_19, label %label_20
label_19:
  %t39 = getelementptr [32 x i8], [32 x i8]* @.str6, i32 0, i32 0
  call void @print(i8* %t39)
  br label %label_21
label_20:
  br label %label_21
label_21:
  %t40 = add i32 1, 0
  %t41 = add i8 1, 0
  %t42 = zext i8 %t41 to i32
  %t43 = icmp ne i32 %t40, %t42
  %t44 = xor i1 %t43, 1
  %t45 = alloca i1
  store i1 0, i1* %t45
  br i1 %t44, label %label_22, label %label_23
label_22:
  %t46 = add i32 8, 0
  %t47 = add i8 2, 0
  %t48 = zext i8 %t47 to i32
  %t49 = icmp sge i32 %t46, %t48
  store i1 %t49, i1* %t45
  br label %label_23
label_23:
  %t50 = load i1, i1* %t45
  br i1 %t50, label %label_24, label %label_25
label_24:
  %t51 = getelementptr [5 x i8], [5 x i8]* @.str7, i32 0, i32 0
  call void @print(i8* %t51)
  br label %label_26
label_25:
  br label %label_26
label_26:
  ret void
  }
  
