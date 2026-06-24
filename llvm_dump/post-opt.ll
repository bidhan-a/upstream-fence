; ModuleID = 'linked_module'
source_filename = "linked_module"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpfel"

; Function Attrs: nounwind
define dso_local noundef i64 @entrypoint(ptr noundef readnone captures(none) %0) unnamed_addr #0 {
  %2 = alloca [8 x i8], align 8
  %3 = alloca [8 x i8], align 8
  %4 = alloca [8 x i8], align 8
  %5 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %5)
  store i64 1229801703532086340, ptr %5, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %4)
  store i64 -6148895925951734307, ptr %4, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store ptr %5, ptr %3, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %3) #5, !srcloc !1
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store ptr %4, ptr %2, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %2) #5, !srcloc !1
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %6 = load i64, ptr %5, align 8, !noundef !2
  %7 = load i64, ptr %4, align 8, !noundef !2
  %8 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %6, i64 %7)
  %9 = extractvalue { i64, i1 } %8, 1
  %10 = extractvalue { i64, i1 } %8, 0
  %11 = xor i64 %10, %7
  %12 = select i1 %9, i64 0, i64 %11, !prof !3
  call void @llvm.lifetime.end.p0(ptr nonnull %4)
  call void @llvm.lifetime.end.p0(ptr nonnull %5)
  ret i64 %12
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #2

; Function Attrs: nounwind
define weak hidden noundef i32 @bcmp(ptr noundef %0, ptr noundef %1, i64 noundef %2) unnamed_addr #3 {
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %.loopexit, label %.preheader

5:                                                ; preds = %.preheader
  %6 = add nuw i64 %8, 1
  %7 = icmp ult i64 %6, %2
  br i1 %7, label %.preheader, label %.loopexit

.preheader:                                       ; preds = %3, %5
  %8 = phi i64 [ %6, %5 ], [ 0, %3 ]
  %9 = getelementptr i8, ptr %0, i64 %8
  %10 = load i8, ptr %9, align 1, !noundef !2
  %11 = getelementptr i8, ptr %1, i64 %8
  %12 = load i8, ptr %11, align 1, !noundef !2
  %13 = icmp eq i8 %10, %12
  br i1 %13, label %5, label %14

14:                                               ; preds = %.preheader
  %15 = zext i8 %10 to i32
  %16 = zext i8 %12 to i32
  %17 = sub nsw i32 %15, %16
  br label %.loopexit

.loopexit:                                        ; preds = %5, %14, %3
  %18 = phi i32 [ %17, %14 ], [ 0, %3 ], [ 0, %5 ]
  ret i32 %18
}

; Function Attrs: nounwind
define weak hidden noundef ptr @memcpy(ptr noundef %0, ptr noundef %1, i64 noundef %2) unnamed_addr #3 {
  %4 = icmp ugt i64 %2, 15
  br i1 %4, label %5, label %11

5:                                                ; preds = %3
  %6 = ptrtoint ptr %0 to i64
  %7 = sub i64 0, %6
  %8 = and i64 %7, 7
  %9 = getelementptr i8, ptr %0, i64 %8
  %10 = icmp ult ptr %0, %9
  br i1 %10, label %.preheader9, label %.loopexit10

11:                                               ; preds = %.loopexit6, %3
  %12 = phi i64 [ %45, %.loopexit6 ], [ %2, %3 ]
  %13 = phi ptr [ %46, %.loopexit6 ], [ %1, %3 ]
  %14 = phi ptr [ %23, %.loopexit6 ], [ %0, %3 ]
  %15 = getelementptr i8, ptr %14, i64 %12
  %16 = icmp ult ptr %14, %15
  br i1 %16, label %.preheader, label %.loopexit

.loopexit10:                                      ; preds = %.preheader9, %5
  %17 = getelementptr i8, ptr %1, i64 %8
  %18 = sub nuw i64 %2, %8
  %19 = and i64 %18, -8
  %20 = ptrtoint ptr %17 to i64
  %21 = and i64 %20, 7
  %22 = icmp eq i64 %21, 0
  %23 = getelementptr i8, ptr %9, i64 %19
  %24 = icmp ult ptr %9, %23
  br i1 %22, label %26, label %25

25:                                               ; preds = %.loopexit10
  br i1 %24, label %.preheader7, label %.loopexit6

26:                                               ; preds = %.loopexit10
  br i1 %24, label %.preheader5, label %.loopexit6

.preheader9:                                      ; preds = %5, %.preheader9
  %27 = phi ptr [ %30, %.preheader9 ], [ %0, %5 ]
  %28 = phi ptr [ %31, %.preheader9 ], [ %1, %5 ]
  %29 = load i8, ptr %28, align 1, !noundef !2
  store i8 %29, ptr %27, align 1
  %30 = getelementptr i8, ptr %27, i64 1
  %31 = getelementptr i8, ptr %28, i64 1
  %32 = icmp ult ptr %30, %9
  br i1 %32, label %.preheader9, label %.loopexit10

.preheader5:                                      ; preds = %26, %.preheader5
  %33 = phi ptr [ %36, %.preheader5 ], [ %9, %26 ]
  %34 = phi ptr [ %37, %.preheader5 ], [ %17, %26 ]
  %35 = load i64, ptr %34, align 8, !noundef !2
  store i64 %35, ptr %33, align 8
  %36 = getelementptr i8, ptr %33, i64 8
  %37 = getelementptr i8, ptr %34, i64 8
  %38 = icmp ult ptr %36, %23
  br i1 %38, label %.preheader5, label %.loopexit6

.preheader7:                                      ; preds = %25, %.preheader7
  %39 = phi ptr [ %42, %.preheader7 ], [ %9, %25 ]
  %40 = phi ptr [ %43, %.preheader7 ], [ %17, %25 ]
  %41 = load i64, ptr %40, align 1
  store i64 %41, ptr %39, align 8
  %42 = getelementptr i8, ptr %39, i64 8
  %43 = getelementptr i8, ptr %40, i64 8
  %44 = icmp ult ptr %42, %23
  br i1 %44, label %.preheader7, label %.loopexit6

.loopexit6:                                       ; preds = %.preheader7, %.preheader5, %26, %25
  %45 = and i64 %18, 7
  %46 = getelementptr i8, ptr %17, i64 %19
  br label %11

.preheader:                                       ; preds = %11, %.preheader
  %47 = phi ptr [ %50, %.preheader ], [ %14, %11 ]
  %48 = phi ptr [ %51, %.preheader ], [ %13, %11 ]
  %49 = load i8, ptr %48, align 1, !noundef !2
  store i8 %49, ptr %47, align 1
  %50 = getelementptr i8, ptr %47, i64 1
  %51 = getelementptr i8, ptr %48, i64 1
  %52 = icmp ult ptr %50, %15
  br i1 %52, label %.preheader, label %.loopexit

.loopexit:                                        ; preds = %.preheader, %11
  ret ptr %0
}

; Function Attrs: nounwind
define weak hidden noundef ptr @memmove(ptr noundef %0, ptr noundef %1, i64 noundef %2) unnamed_addr #3 {
  %4 = ptrtoint ptr %0 to i64
  %5 = ptrtoint ptr %1 to i64
  %6 = sub i64 %4, %5
  %7 = icmp ult i64 %6, %2
  br i1 %7, label %8, label %62

8:                                                ; preds = %3
  %9 = getelementptr i8, ptr %0, i64 %2
  %10 = getelementptr i8, ptr %1, i64 %2
  %11 = icmp ugt i64 %2, 15
  br i1 %11, label %12, label %18

12:                                               ; preds = %8
  %13 = ptrtoint ptr %9 to i64
  %14 = and i64 %13, 7
  %15 = sub nsw i64 0, %14
  %16 = getelementptr i8, ptr %9, i64 %15
  %17 = icmp ult ptr %16, %9
  br i1 %17, label %.preheader12.i, label %.loopexit13.i

18:                                               ; preds = %.loopexit9.i, %8
  %19 = phi ptr [ %32, %.loopexit9.i ], [ %9, %8 ]
  %20 = phi ptr [ %55, %.loopexit9.i ], [ %10, %8 ]
  %21 = phi i64 [ %54, %.loopexit9.i ], [ %2, %8 ]
  %22 = sub nsw i64 0, %21
  %23 = getelementptr i8, ptr %19, i64 %22
  %24 = icmp ult ptr %23, %19
  br i1 %24, label %.preheader.i, label %_RNvNtCslPiyrxoxFGw_17compiler_builtins3mem7memmove.exit

.loopexit13.i:                                    ; preds = %.preheader12.i, %12
  %25 = getelementptr i8, ptr %10, i64 %15
  %26 = sub nuw i64 %2, %14
  %27 = and i64 %26, -8
  %28 = ptrtoint ptr %25 to i64
  %29 = and i64 %28, 7
  %30 = icmp eq i64 %29, 0
  %31 = sub i64 0, %27
  %32 = getelementptr i8, ptr %16, i64 %31
  %33 = icmp ult ptr %32, %16
  br i1 %30, label %35, label %34

34:                                               ; preds = %.loopexit13.i
  br i1 %33, label %.preheader10.i, label %.loopexit9.i

35:                                               ; preds = %.loopexit13.i
  br i1 %33, label %.preheader8.i, label %.loopexit9.i

.preheader12.i:                                   ; preds = %12, %.preheader12.i
  %36 = phi ptr [ %38, %.preheader12.i ], [ %9, %12 ]
  %37 = phi ptr [ %39, %.preheader12.i ], [ %10, %12 ]
  %38 = getelementptr i8, ptr %36, i64 -1
  %39 = getelementptr i8, ptr %37, i64 -1
  %40 = load i8, ptr %39, align 1, !noundef !2
  store i8 %40, ptr %38, align 1
  %41 = icmp ult ptr %16, %38
  br i1 %41, label %.preheader12.i, label %.loopexit13.i

.preheader10.i:                                   ; preds = %34, %.preheader10.i
  %42 = phi ptr [ %44, %.preheader10.i ], [ %16, %34 ]
  %43 = phi ptr [ %45, %.preheader10.i ], [ %25, %34 ]
  %44 = getelementptr i8, ptr %42, i64 -8
  %45 = getelementptr i8, ptr %43, i64 -8
  %46 = load i64, ptr %45, align 1
  store i64 %46, ptr %44, align 8
  %47 = icmp ult ptr %32, %44
  br i1 %47, label %.preheader10.i, label %.loopexit9.i

.preheader8.i:                                    ; preds = %35, %.preheader8.i
  %48 = phi ptr [ %50, %.preheader8.i ], [ %16, %35 ]
  %49 = phi ptr [ %51, %.preheader8.i ], [ %25, %35 ]
  %50 = getelementptr i8, ptr %48, i64 -8
  %51 = getelementptr i8, ptr %49, i64 -8
  %52 = load i64, ptr %51, align 8, !noundef !2
  store i64 %52, ptr %50, align 8
  %53 = icmp ult ptr %32, %50
  br i1 %53, label %.preheader8.i, label %.loopexit9.i

.loopexit9.i:                                     ; preds = %.preheader10.i, %.preheader8.i, %35, %34
  %54 = and i64 %26, 7
  %55 = getelementptr i8, ptr %25, i64 %31
  br label %18

.preheader.i:                                     ; preds = %18, %.preheader.i
  %56 = phi ptr [ %59, %.preheader.i ], [ %20, %18 ]
  %57 = phi ptr [ %58, %.preheader.i ], [ %19, %18 ]
  %58 = getelementptr i8, ptr %57, i64 -1
  %59 = getelementptr i8, ptr %56, i64 -1
  %60 = load i8, ptr %59, align 1, !noundef !2
  store i8 %60, ptr %58, align 1
  %61 = icmp ult ptr %23, %58
  br i1 %61, label %.preheader.i, label %_RNvNtCslPiyrxoxFGw_17compiler_builtins3mem7memmove.exit

62:                                               ; preds = %3
  %63 = icmp ugt i64 %2, 15
  br i1 %63, label %64, label %69

64:                                               ; preds = %62
  %65 = sub i64 0, %4
  %66 = and i64 %65, 7
  %67 = getelementptr i8, ptr %0, i64 %66
  %68 = icmp ult ptr %0, %67
  br i1 %68, label %.preheader20.i, label %.loopexit21.i

69:                                               ; preds = %.loopexit17.i, %62
  %70 = phi i64 [ %103, %.loopexit17.i ], [ %2, %62 ]
  %71 = phi ptr [ %104, %.loopexit17.i ], [ %1, %62 ]
  %72 = phi ptr [ %81, %.loopexit17.i ], [ %0, %62 ]
  %73 = getelementptr i8, ptr %72, i64 %70
  %74 = icmp ult ptr %72, %73
  br i1 %74, label %.preheader14.i, label %_RNvNtCslPiyrxoxFGw_17compiler_builtins3mem7memmove.exit

.loopexit21.i:                                    ; preds = %.preheader20.i, %64
  %75 = getelementptr i8, ptr %1, i64 %66
  %76 = sub nuw i64 %2, %66
  %77 = and i64 %76, -8
  %78 = ptrtoint ptr %75 to i64
  %79 = and i64 %78, 7
  %80 = icmp eq i64 %79, 0
  %81 = getelementptr i8, ptr %67, i64 %77
  %82 = icmp ult ptr %67, %81
  br i1 %80, label %84, label %83

83:                                               ; preds = %.loopexit21.i
  br i1 %82, label %.preheader18.i, label %.loopexit17.i

84:                                               ; preds = %.loopexit21.i
  br i1 %82, label %.preheader16.i, label %.loopexit17.i

.preheader20.i:                                   ; preds = %64, %.preheader20.i
  %85 = phi ptr [ %88, %.preheader20.i ], [ %0, %64 ]
  %86 = phi ptr [ %89, %.preheader20.i ], [ %1, %64 ]
  %87 = load i8, ptr %86, align 1, !noundef !2
  store i8 %87, ptr %85, align 1
  %88 = getelementptr i8, ptr %85, i64 1
  %89 = getelementptr i8, ptr %86, i64 1
  %90 = icmp ult ptr %88, %67
  br i1 %90, label %.preheader20.i, label %.loopexit21.i

.preheader16.i:                                   ; preds = %84, %.preheader16.i
  %91 = phi ptr [ %94, %.preheader16.i ], [ %67, %84 ]
  %92 = phi ptr [ %95, %.preheader16.i ], [ %75, %84 ]
  %93 = load i64, ptr %92, align 8, !noundef !2
  store i64 %93, ptr %91, align 8
  %94 = getelementptr i8, ptr %91, i64 8
  %95 = getelementptr i8, ptr %92, i64 8
  %96 = icmp ult ptr %94, %81
  br i1 %96, label %.preheader16.i, label %.loopexit17.i

.preheader18.i:                                   ; preds = %83, %.preheader18.i
  %97 = phi ptr [ %100, %.preheader18.i ], [ %67, %83 ]
  %98 = phi ptr [ %101, %.preheader18.i ], [ %75, %83 ]
  %99 = load i64, ptr %98, align 1
  store i64 %99, ptr %97, align 8
  %100 = getelementptr i8, ptr %97, i64 8
  %101 = getelementptr i8, ptr %98, i64 8
  %102 = icmp ult ptr %100, %81
  br i1 %102, label %.preheader18.i, label %.loopexit17.i

.loopexit17.i:                                    ; preds = %.preheader18.i, %.preheader16.i, %84, %83
  %103 = and i64 %76, 7
  %104 = getelementptr i8, ptr %75, i64 %77
  br label %69

.preheader14.i:                                   ; preds = %69, %.preheader14.i
  %105 = phi ptr [ %108, %.preheader14.i ], [ %72, %69 ]
  %106 = phi ptr [ %109, %.preheader14.i ], [ %71, %69 ]
  %107 = load i8, ptr %106, align 1, !noundef !2
  store i8 %107, ptr %105, align 1
  %108 = getelementptr i8, ptr %105, i64 1
  %109 = getelementptr i8, ptr %106, i64 1
  %110 = icmp ult ptr %108, %73
  br i1 %110, label %.preheader14.i, label %_RNvNtCslPiyrxoxFGw_17compiler_builtins3mem7memmove.exit

_RNvNtCslPiyrxoxFGw_17compiler_builtins3mem7memmove.exit: ; preds = %.preheader14.i, %.preheader.i, %18, %69
  ret ptr %0
}

; Function Attrs: nounwind
define weak hidden noundef ptr @memset(ptr noundef %0, i32 noundef %1, i64 noundef %2) unnamed_addr #3 {
  %4 = trunc i32 %1 to i8
  %5 = icmp ugt i64 %2, 15
  br i1 %5, label %6, label %12

6:                                                ; preds = %3
  %7 = ptrtoint ptr %0 to i64
  %8 = sub i64 0, %7
  %9 = and i64 %8, 7
  %10 = getelementptr i8, ptr %0, i64 %9
  %11 = icmp ult ptr %0, %10
  br i1 %11, label %.preheader6, label %.loopexit7

12:                                               ; preds = %.loopexit5, %3
  %13 = phi i64 [ %31, %.loopexit5 ], [ %2, %3 ]
  %14 = phi ptr [ %26, %.loopexit5 ], [ %0, %3 ]
  %15 = getelementptr i8, ptr %14, i64 %13
  %16 = icmp ult ptr %14, %15
  br i1 %16, label %.preheader, label %.loopexit

.preheader6:                                      ; preds = %6, %.preheader6
  %17 = phi ptr [ %18, %.preheader6 ], [ %0, %6 ]
  store i8 %4, ptr %17, align 1
  %18 = getelementptr i8, ptr %17, i64 1
  %19 = icmp ult ptr %18, %10
  br i1 %19, label %.preheader6, label %.loopexit7

.loopexit7:                                       ; preds = %.preheader6, %6
  %20 = and i32 %1, 255
  %21 = mul nuw i32 %20, 16843009
  %22 = zext i32 %21 to i64
  %23 = mul nuw i64 %22, 4294967297
  %24 = sub nuw i64 %2, %9
  %25 = and i64 %24, -8
  %26 = getelementptr i8, ptr %10, i64 %25
  %27 = icmp ult ptr %10, %26
  br i1 %27, label %.preheader4, label %.loopexit5

.preheader4:                                      ; preds = %.loopexit7, %.preheader4
  %28 = phi ptr [ %29, %.preheader4 ], [ %10, %.loopexit7 ]
  store i64 %23, ptr %28, align 8
  %29 = getelementptr i8, ptr %28, i64 8
  %30 = icmp ult ptr %29, %26
  br i1 %30, label %.preheader4, label %.loopexit5

.loopexit5:                                       ; preds = %.preheader4, %.loopexit7
  %31 = and i64 %24, 7
  br label %12

.preheader:                                       ; preds = %12, %.preheader
  %32 = phi ptr [ %33, %.preheader ], [ %14, %12 ]
  store i8 %4, ptr %32, align 1
  %33 = getelementptr i8, ptr %32, i64 1
  %34 = icmp ult ptr %33, %15
  br i1 %34, label %.preheader, label %.loopexit

.loopexit:                                        ; preds = %.preheader, %12
  ret ptr %0
}

; Function Attrs: nounwind memory(inaccessiblemem: readwrite)
define hidden void @__multi3(i128 noundef %0, i128 noundef %1) unnamed_addr #4 {
  %3 = trunc i128 %0 to i64
  %4 = lshr i64 %3, 32
  %5 = trunc i128 %1 to i64
  %6 = lshr i64 %5, 32
  %7 = mul nuw i64 %6, %4
  %8 = and i64 %3, 4294967295
  %9 = and i64 %5, 4294967295
  %10 = mul nuw i64 %9, %8
  %11 = lshr i64 %10, 32
  %12 = mul nuw i64 %9, %4
  %13 = add nuw i64 %11, %12
  %14 = lshr i64 %13, 32
  %15 = and i64 %13, 4294967295
  %16 = mul nuw i64 %6, %8
  %17 = add nuw i64 %15, %16
  %18 = lshr i64 %17, 32
  %19 = and i64 %10, 4294967295
  %20 = shl i64 %17, 32
  %21 = or disjoint i64 %20, %19
  %22 = lshr i128 %1, 64
  %23 = trunc nuw i128 %22 to i64
  %24 = lshr i128 %0, 64
  %25 = trunc nuw i128 %24 to i64
  %26 = mul i64 %25, %5
  %27 = mul i64 %23, %3
  %28 = add i64 %7, %26
  %29 = add i64 %28, %27
  %30 = add i64 %29, %14
  %31 = add i64 %30, %18
  %32 = tail call { i64, i64 } asm sideeffect "r0 = ${2}\0Ar2 = ${3}", "=&{r0},=&{r2},r,r"(i64 %21, i64 %31) #6, !srcloc !4
  ret void
}

; Function Attrs: nounwind
define hidden noundef i32 @memcmp(ptr noundef %0, ptr noundef %1, i64 noundef %2) local_unnamed_addr #0 {
  %4 = alloca [4 x i8], align 4
  %5 = icmp ugt i64 %2, 32
  br i1 %5, label %6, label %.preheader4

6:                                                ; preds = %3
  call void @llvm.lifetime.start.p0(ptr nonnull %4)
  store i32 0, ptr %4, align 4
  %7 = call noundef i32 inttoptr (i64 1608310321 to ptr)(ptr noundef %0, ptr noundef %1, i64 noundef %2, ptr noundef nonnull %4) #5
  %8 = load i32, ptr %4, align 4, !noundef !2
  call void @llvm.lifetime.end.p0(ptr nonnull %4)
  br label %.loopexit

.preheader4:                                      ; preds = %3, %14
  %9 = phi i64 [ %10, %14 ], [ 0, %3 ]
  %10 = add nuw i64 %9, 8
  %11 = icmp ugt i64 %10, %2
  br i1 %11, label %12, label %14

12:                                               ; preds = %.preheader4
  %13 = icmp ult i64 %9, %2
  br i1 %13, label %.preheader, label %.loopexit

14:                                               ; preds = %.preheader4
  %15 = getelementptr inbounds nuw i8, ptr %0, i64 %9
  %16 = load i64, ptr %15, align 1
  %17 = getelementptr inbounds nuw i8, ptr %1, i64 %9
  %18 = load i64, ptr %17, align 1
  %19 = icmp eq i64 %16, %18
  br i1 %19, label %.preheader4, label %.loopexit

20:                                               ; preds = %.preheader
  %21 = add nuw nsw i64 %23, 1
  %22 = icmp ult i64 %21, %2
  br i1 %22, label %.preheader, label %.loopexit

.preheader:                                       ; preds = %12, %20
  %23 = phi i64 [ %21, %20 ], [ %9, %12 ]
  %24 = getelementptr inbounds nuw i8, ptr %0, i64 %23
  %25 = load i8, ptr %24, align 1, !noundef !2
  %26 = getelementptr inbounds nuw i8, ptr %1, i64 %23
  %27 = load i8, ptr %26, align 1, !noundef !2
  %28 = icmp eq i8 %25, %27
  br i1 %28, label %20, label %.loopexit

.loopexit:                                        ; preds = %14, %.preheader, %20, %12, %6
  %29 = phi i32 [ %8, %6 ], [ 0, %12 ], [ 1, %.preheader ], [ 0, %20 ], [ 1, %14 ]
  ret i32 %29
}

attributes #0 = { nounwind "target-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind "no-builtins" "target-cpu"="generic" }
attributes #4 = { nounwind memory(inaccessiblemem: readwrite) "target-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { nounwind memory(inaccessiblemem: readwrite) }

!llvm.ident = !{!0}

!0 = !{!"rustc version 1.98.0-nightly (f28ac764c 2026-06-23)"}
!1 = !{i64 940928550524834}
!2 = !{}
!3 = !{!"branch_weights", !"expected", i32 1, i32 2000}
!4 = !{i64 11016591116795, i64 11132555233813}
