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
@.str1 = constant [12 x i8] c"already? :(\00"
@.str2 = constant [3 x i8] c"ok\00"
@.str3 = constant [8 x i8] c"alright\00"
@.str4 = constant [6 x i8] c"back!\00"
@.str5 = constant [6 x i8] c"here!\00"

  define i32 @foo(i1, i32, i8) {
  entry:
  %t1 = alloca i1
  store i1 %0, i1* %t1
  %t2 = alloca i32
  store i32 %1, i32* %t2
  %t3 = alloca i8
  store i8 %2, i8* %t3
  %t4 = alloca i32
  %t5 = load i32, i32* %t2
  store i32 %t5, i32* %t4
  %t6 = alloca i8
  %t7 = load i8, i8* %t3
  store i8 %t7, i8* %t6
  %t8 = load i1, i1* %t1
  %t9 = xor i1 %t8, 1
  br i1 %t9, label %label_2, label %label_3
label_2:
  %t10 = getelementptr [12 x i8], [12 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t10)
  %t11 = add i32 15, 0
  ret i32 %t11
label_3:
  br label %label_4
label_4:
  %t12 = getelementptr [3 x i8], [3 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t12)
  br label %label_5
label_5:
  %t13 = load i32, i32* %t4
  %t14 = add i32 10, 0
  %t15 = icmp slt i32 %t13, %t14
  br i1 %t15, label %label_6, label %label_7
label_6:
  %t16 = load i32, i32* %t4
  %t17 = add i32 1, 0
  %t18 = add i32 %t16, %t17
  store i32 %t18, i32* %t4
  %t19 = load i1, i1* %t1
  %t20 = alloca i1
  store i1 0, i1* %t20
  br i1 %t19, label %label_8, label %label_9
label_8:
  %t21 = load i32, i32* %t4
  %t22 = add i32 7, 0
  %t23 = icmp eq i32 %t21, %t22
  store i1 %t23, i1* %t20
  br label %label_9
label_9:
  %t24 = load i1, i1* %t20
  br i1 %t24, label %label_10, label %label_11
label_10:
  %t25 = load i32, i32* %t4
  call void @printi(i32 %t25)
  %t26 = getelementptr [8 x i8], [8 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t26)
  %t27 = add i32 17, 0
  ret i32 %t27
label_11:
  br label %label_12
label_12:
  br label %label_5
label_7:
  br label %label_13
label_13:
  %t28 = load i8, i8* %t6
  %t29 = add i8 12, 0
  %t30 = icmp ugt i8 %t28, %t29
  br i1 %t30, label %label_14, label %label_15
label_14:
  %t31 = load i8, i8* %t6
  %t32 = add i8 1, 0
  %t33 = sub i8 %t31, %t32
  store i8 %t33, i8* %t6
  %t34 = load i8, i8* %t6
  %t35 = zext i8 %t34 to i32
  call void @printi(i32 %t35)
  %t36 = getelementptr [6 x i8], [6 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t36)
  %t37 = add i32 18, 0
  ret i32 %t37
label_15:
  %t38 = getelementptr [6 x i8], [6 x i8]* @.str5, i32 0, i32 0
  call void @print(i8* %t38)
  %t39 = add i32 322, 0
  ret i32 %t39
  }
  
  define i1 @opposite(i1) {
  entry:
  %t40 = alloca i1
  store i1 %0, i1* %t40
  br label %label_17
label_17:
  %t41 = add i1 1, 0
  br i1 %t41, label %label_18, label %label_19
label_18:
  br label %label_20
label_20:
  %t42 = add i1 1, 0
  br i1 %t42, label %label_21, label %label_22
label_21:
  br label %label_23
label_23:
  %t43 = add i1 1, 0
  br i1 %t43, label %label_24, label %label_25
label_24:
  br label %label_26
label_26:
  %t44 = add i1 1, 0
  br i1 %t44, label %label_27, label %label_28
label_27:
  br label %label_29
label_29:
  %t45 = add i1 1, 0
  br i1 %t45, label %label_30, label %label_31
label_30:
  %t46 = load i1, i1* %t40
  %t47 = xor i1 %t46, 1
  ret i1 %t47
label_31:
  br label %label_28
label_28:
  br label %label_23
label_25:
  br label %label_20
label_22:
  br label %label_17
label_19:
  %t48 = load i1, i1* %t40
  %t49 = xor i1 %t48, 1
  ret i1 %t49
  }
  
  define i8 @multiply(i8, i8) {
  entry:
  %t50 = alloca i8
  store i8 %0, i8* %t50
  %t51 = alloca i8
  store i8 %1, i8* %t51
  %t52 = load i8, i8* %t50
  %t53 = load i8, i8* %t51
  %t54 = mul i8 %t52, %t53
  ret i8 %t54
  }
  
  define void @main() {
  entry:
  %t55 = add i1 0, 0
  %t56 = add i32 5, 0
  %t57 = add i8 15, 0
  %t58 = call i32 @foo(i1 %t55, i32 %t56, i8 %t57)
  call void @printi(i32 %t58)
  }
  
