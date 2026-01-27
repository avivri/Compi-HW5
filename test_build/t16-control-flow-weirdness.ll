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
@.str6 = constant [6 x i8] c"great\00"

  define i32 @foo(i32, i32, i32) {
  entry:
  %t1 = alloca i32
  store i32 %0, i32* %t1
  %t2 = alloca i32
  store i32 %1, i32* %t2
  %t3 = alloca i32
  store i32 %2, i32* %t3
  %t4 = alloca i32
  %t5 = load i32, i32* %t2
  store i32 %t5, i32* %t4
  %t6 = alloca i32
  %t7 = load i32, i32* %t3
  store i32 %t7, i32* %t6
  %t8 = load i32, i32* %t1
  %t9 = xor i32 %t8, 1
  %t10 = icmp ne i32 %t9, 0
  br i1 %t10, label %label_2, label %label_3
label_2:
  %t11 = getelementptr [12 x i8], [12 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t11)
  %t12 = add i32 15, 0
  ret i32 %t12
label_5:
  br label %label_4
label_3:
  br label %label_4
label_4:
  %t13 = getelementptr [3 x i8], [3 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t13)
  br label %label_6
label_6:
  %t14 = load i32, i32* %t4
  %t15 = add i32 10, 0
  %t16 = icmp slt i32 %t14, %t15
  %t17 = zext i1 %t16 to i32
  %t18 = icmp ne i32 %t17, 0
  br i1 %t18, label %label_7, label %label_8
label_7:
  %t19 = load i32, i32* %t4
  %t20 = add i32 1, 0
  %t21 = add i32 %t19, %t20
  store i32 %t21, i32* %t4
  %t22 = load i32, i32* %t1
  %t23 = alloca i32
  store i32 0, i32* %t23
  %t24 = icmp ne i32 %t22, 0
  br i1 %t24, label %label_9, label %label_10
label_9:
  %t25 = load i32, i32* %t4
  %t26 = add i32 7, 0
  %t27 = icmp eq i32 %t25, %t26
  %t28 = zext i1 %t27 to i32
  store i32 %t28, i32* %t23
  br label %label_10
label_10:
  %t29 = load i32, i32* %t23
  %t30 = icmp ne i32 %t29, 0
  br i1 %t30, label %label_11, label %label_12
label_11:
  %t31 = load i32, i32* %t4
  call void @printi(i32 %t31)
  %t32 = getelementptr [8 x i8], [8 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t32)
  %t33 = add i32 17, 0
  ret i32 %t33
label_14:
  br label %label_13
label_12:
  br label %label_13
label_13:
  br label %label_6
label_8:
  br label %label_15
label_15:
  %t34 = load i32, i32* %t6
  %t35 = add i32 12, 0
  %t36 = icmp ugt i32 %t34, %t35
  %t37 = zext i1 %t36 to i32
  %t38 = icmp ne i32 %t37, 0
  br i1 %t38, label %label_16, label %label_17
label_16:
  %t39 = load i32, i32* %t6
  %t40 = add i32 1, 0
  %t41 = sub i32 %t39, %t40
  %t42 = and i32 %t41, 255
  store i32 %t42, i32* %t6
  %t43 = load i32, i32* %t6
  call void @printi(i32 %t43)
  %t44 = getelementptr [6 x i8], [6 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t44)
  %t45 = add i32 18, 0
  ret i32 %t45
label_18:
  br label %label_15
label_17:
  %t46 = getelementptr [6 x i8], [6 x i8]* @.str5, i32 0, i32 0
  call void @print(i8* %t46)
  %t47 = add i32 322, 0
  ret i32 %t47
label_19:
  ret i32 0
  }
  
  define i32 @opposite(i32) {
  entry:
  %t48 = alloca i32
  store i32 %0, i32* %t48
  br label %label_21
label_21:
  %t49 = add i32 1, 0
  %t50 = icmp ne i32 %t49, 0
  br i1 %t50, label %label_22, label %label_23
label_22:
  br label %label_24
label_24:
  %t51 = add i32 1, 0
  %t52 = icmp ne i32 %t51, 0
  br i1 %t52, label %label_25, label %label_26
label_25:
  br label %label_27
label_27:
  %t53 = add i32 1, 0
  %t54 = icmp ne i32 %t53, 0
  br i1 %t54, label %label_28, label %label_29
label_28:
  br label %label_30
label_30:
  %t55 = add i32 1, 0
  %t56 = icmp ne i32 %t55, 0
  br i1 %t56, label %label_31, label %label_32
label_31:
  br label %label_33
label_33:
  %t57 = add i32 1, 0
  %t58 = icmp ne i32 %t57, 0
  br i1 %t58, label %label_34, label %label_35
label_34:
  %t59 = load i32, i32* %t48
  %t60 = xor i32 %t59, 1
  ret i32 %t60
label_36:
  br label %label_33
label_35:
  br label %label_32
label_37:
  br label %label_30
label_32:
  br label %label_27
label_29:
  br label %label_24
label_26:
  br label %label_21
label_23:
  %t61 = load i32, i32* %t48
  %t62 = xor i32 %t61, 1
  ret i32 %t62
label_38:
  ret i32 0
  }
  
  define i32 @multiply(i32, i32) {
  entry:
  %t63 = alloca i32
  store i32 %0, i32* %t63
  %t64 = alloca i32
  store i32 %1, i32* %t64
  %t65 = load i32, i32* %t63
  %t66 = load i32, i32* %t64
  %t67 = mul i32 %t65, %t66
  %t68 = and i32 %t67, 255
  ret i32 %t68
label_40:
  ret i32 0
  }
  
  define void @main() {
  entry:
  %t69 = add i32 0, 0
  %t70 = add i32 5, 0
  %t71 = add i32 15, 0
  %t72 = call i32 @foo(i32 %t69, i32 %t70, i32 %t71)
  call void @printi(i32 %t72)
  %t73 = add i32 1, 0
  %t74 = add i32 5, 0
  %t75 = add i32 21, 0
  %t76 = call i32 @foo(i32 %t73, i32 %t74, i32 %t75)
  call void @printi(i32 %t76)
  %t77 = add i32 1, 0
  %t78 = add i32 11, 0
  %t79 = add i32 4, 0
  %t80 = call i32 @foo(i32 %t77, i32 %t78, i32 %t79)
  call void @printi(i32 %t80)
  %t81 = add i32 1, 0
  %t82 = add i32 10, 0
  %t83 = add i32 13, 0
  %t84 = call i32 @foo(i32 %t81, i32 %t82, i32 %t83)
  call void @printi(i32 %t84)
  %t85 = add i32 0, 0
  %t86 = call i32 @opposite(i32 %t85)
  %t87 = icmp ne i32 %t86, 0
  br i1 %t87, label %label_42, label %label_43
label_42:
  %t88 = getelementptr [6 x i8], [6 x i8]* @.str6, i32 0, i32 0
  call void @print(i8* %t88)
  br label %label_44
label_43:
  br label %label_44
label_44:
  %t89 = add i32 16, 0
  %t90 = add i32 16, 0
  %t91 = call i32 @multiply(i32 %t89, i32 %t90)
  call void @printi(i32 %t91)
  ret void
  }
  
