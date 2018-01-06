; ModuleID = 'point_struct.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.foo = type { i32, i32, i32 (i32, i32)* }

@.str = private unnamed_addr constant [4 x i8] c"foo\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"klee_choose\00", align 1
@.str12 = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str123 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str6 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @add(i32 %a, i32 %b) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %a, i32* %1, align 4
  store i32 %b, i32* %2, align 4
  %3 = load i32* %1, align 4, !dbg !154
  %4 = load i32* %2, align 4, !dbg !154
  %5 = add nsw i32 %3, %4, !dbg !154
  ret i32 %5, !dbg !154
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @bar(%struct.foo* %foo_ptr_temp) #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.foo*, align 8
  %sum = alloca i32, align 4
  store %struct.foo* %foo_ptr_temp, %struct.foo** %2, align 8
  %3 = load %struct.foo** %2, align 8, !dbg !155
  %4 = getelementptr inbounds %struct.foo* %3, i32 0, i32 2, !dbg !155
  store i32 (i32, i32)* @add, i32 (i32, i32)** %4, align 8, !dbg !155
  %5 = load %struct.foo** %2, align 8, !dbg !156
  %6 = getelementptr inbounds %struct.foo* %5, i32 0, i32 2, !dbg !156
  %7 = load i32 (i32, i32)** %6, align 8, !dbg !156
  %8 = load %struct.foo** %2, align 8, !dbg !156
  %9 = getelementptr inbounds %struct.foo* %8, i32 0, i32 0, !dbg !156
  %10 = load i32* %9, align 4, !dbg !156
  %11 = load %struct.foo** %2, align 8, !dbg !156
  %12 = getelementptr inbounds %struct.foo* %11, i32 0, i32 1, !dbg !156
  %13 = load i32* %12, align 4, !dbg !156
  %14 = call i32 %7(i32 %10, i32 %13), !dbg !156
  store i32 %14, i32* %sum, align 4, !dbg !156
  %15 = load i32* %sum, align 4, !dbg !157
  %16 = icmp sgt i32 %15, 5, !dbg !157
  br i1 %16, label %17, label %18, !dbg !157

; <label>:17                                      ; preds = %0
  store i32 8, i32* %1, !dbg !159
  br label %19, !dbg !159

; <label>:18                                      ; preds = %0
  store i32 10, i32* %1, !dbg !161
  br label %19, !dbg !161

; <label>:19                                      ; preds = %18, %17
  %20 = load i32* %1, !dbg !163
  ret i32 %20, !dbg !163
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %foo_ptr = alloca %struct.foo*, align 8
  store i32 0, i32* %1
  %2 = call noalias i8* @malloc(i64 16) #7, !dbg !164
  %3 = bitcast i8* %2 to %struct.foo*, !dbg !164
  store %struct.foo* %3, %struct.foo** %foo_ptr, align 8, !dbg !164
  %4 = load %struct.foo** %foo_ptr, align 8, !dbg !165
  %5 = bitcast %struct.foo* %4 to i8*, !dbg !165
  call void @klee_make_symbolic(i8* %5, i64 16, i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)), !dbg !165
  %6 = load %struct.foo** %foo_ptr, align 8, !dbg !166
  %7 = call i32 @bar(%struct.foo* %6), !dbg !166
  ret i32 %7, !dbg !166
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

declare void @klee_make_symbolic(i8*, i64, i8*) #3

; Function Attrs: nounwind ssp uwtable
define i64 @klee_choose(i64 %n) #4 {
  %x = alloca i64, align 8
  %1 = bitcast i64* %x to i8*, !dbg !167
  call void @klee_make_symbolic(i8* %1, i64 8, i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0)) #8, !dbg !167
  %2 = load i64* %x, align 8, !dbg !168, !tbaa !170
  %3 = icmp ult i64 %2, %n, !dbg !168
  br i1 %3, label %5, label %4, !dbg !168

; <label>:4                                       ; preds = %0
  call void @klee_silent_exit(i32 0) #9, !dbg !174
  unreachable, !dbg !174

; <label>:5                                       ; preds = %0
  ret i64 %2, !dbg !175
}

; Function Attrs: noreturn
declare void @klee_silent_exit(i32) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind ssp uwtable
define void @klee_div_zero_check(i64 %z) #4 {
  %1 = icmp eq i64 %z, 0, !dbg !176
  br i1 %1, label %2, label %3, !dbg !176

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str12, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str123, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #9, !dbg !178
  unreachable, !dbg !178

; <label>:3                                       ; preds = %0
  ret void, !dbg !179
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind ssp uwtable
define i32 @klee_int(i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !180
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #8, !dbg !180
  %2 = load i32* %x, align 4, !dbg !181, !tbaa !182
  ret i32 %2, !dbg !181
}

; Function Attrs: nounwind ssp uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !184
  br i1 %1, label %3, label %2, !dbg !184

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #9, !dbg !186
  unreachable, !dbg !186

; <label>:3                                       ; preds = %0
  ret void, !dbg !188
}

; Function Attrs: nounwind ssp uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !189
  br i1 %1, label %3, label %2, !dbg !189

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #9, !dbg !191
  unreachable, !dbg !191

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !192
  %5 = icmp eq i32 %4, %end, !dbg !192
  br i1 %5, label %21, label %6, !dbg !192

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !194
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #8, !dbg !194
  %8 = icmp eq i32 %start, 0, !dbg !196
  %9 = load i32* %x, align 4, !dbg !198, !tbaa !182
  br i1 %8, label %10, label %13, !dbg !196

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !198
  %12 = zext i1 %11 to i64, !dbg !198
  call void @klee_assume(i64 %12) #8, !dbg !198
  br label %19, !dbg !200

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !201
  %15 = zext i1 %14 to i64, !dbg !201
  call void @klee_assume(i64 %15) #8, !dbg !201
  %16 = load i32* %x, align 4, !dbg !203, !tbaa !182
  %17 = icmp slt i32 %16, %end, !dbg !203
  %18 = zext i1 %17 to i64, !dbg !203
  call void @klee_assume(i64 %18) #8, !dbg !203
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !204, !tbaa !182
  br label %21, !dbg !204

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !205
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind ssp uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !206
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !206

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep4 = getelementptr i8* %srcaddr, i64 %2
  %scevgep = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep4, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end6 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep103 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !207
  %wide.load = load <16 x i8>* %3, align 1, !dbg !207
  %next.gep.sum279 = or i64 %index, 16, !dbg !207
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !207
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !207
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !207
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !207
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !207
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum279, !dbg !207
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !207
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !207
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !208

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val5 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end6, %vector.body ]
  %resume.val7 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val5, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val7, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !206
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !207
  %12 = load i8* %src.03, align 1, !dbg !207, !tbaa !211
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !207
  store i8 %12, i8* %dest.02, align 1, !dbg !207, !tbaa !211
  %14 = icmp eq i64 %10, 0, !dbg !206
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !206, !llvm.loop !212

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !213
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
  %1 = icmp eq i8* %src, %dst, !dbg !214
  br i1 %1, label %.loopexit, label %2, !dbg !214

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !216
  br i1 %3, label %.preheader, label %18, !dbg !216

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !218
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !218

.lr.ph.preheader:                                 ; preds = %.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %5 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep11 = getelementptr i8* %src, i64 %5
  %scevgep = getelementptr i8* %dst, i64 %5
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep11, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end13 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep110 = getelementptr i8* %dst, i64 %index
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !218
  %wide.load = load <16 x i8>* %6, align 1, !dbg !218
  %next.gep.sum586 = or i64 %index, 16, !dbg !218
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !218
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !218
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !218
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !218
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !218
  %10 = getelementptr i8* %dst, i64 %next.gep.sum586, !dbg !218
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !218
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !218
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !220

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %src, %.lr.ph.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val12 = phi i8* [ %dst, %.lr.ph.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end13, %vector.body ]
  %resume.val14 = phi i64 [ %count, %.lr.ph.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %b.04 = phi i8* [ %14, %.lr.ph ], [ %resume.val, %middle.block ]
  %a.03 = phi i8* [ %16, %.lr.ph ], [ %resume.val12, %middle.block ]
  %.02 = phi i64 [ %13, %.lr.ph ], [ %resume.val14, %middle.block ]
  %13 = add i64 %.02, -1, !dbg !218
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !218
  %15 = load i8* %b.04, align 1, !dbg !218, !tbaa !211
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !218
  store i8 %15, i8* %a.03, align 1, !dbg !218, !tbaa !211
  %17 = icmp eq i64 %13, 0, !dbg !218
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !218, !llvm.loop !221

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !222
  %20 = icmp eq i64 %count, 0, !dbg !224
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !224

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !225
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !222
  %n.vec215 = and i64 %count, -32
  %cmp.zero217 = icmp eq i64 %n.vec215, 0
  br i1 %cmp.zero217, label %middle.block210, label %vector.memcheck224

vector.memcheck224:                               ; preds = %.lr.ph9
  %bound1221 = icmp ule i8* %21, %dst
  %bound0220 = icmp ule i8* %22, %src
  %memcheck.conflict223 = and i1 %bound0220, %bound1221
  %.sum = sub i64 %19, %n.vec215
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %.sum
  %rev.ptr.ind.end229 = getelementptr i8* %dst, i64 %.sum
  %rev.ind.end231 = sub i64 %count, %n.vec215
  br i1 %memcheck.conflict223, label %middle.block210, label %vector.body209

vector.body209:                                   ; preds = %vector.body209, %vector.memcheck224
  %index212 = phi i64 [ %index.next234, %vector.body209 ], [ 0, %vector.memcheck224 ]
  %.sum440 = sub i64 %19, %index212
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !224
  %23 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !224
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !224
  %wide.load434 = load <16 x i8>* %24, align 1, !dbg !224
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !224
  %.sum505 = add i64 %.sum440, -31, !dbg !224
  %25 = getelementptr i8* %src, i64 %.sum505, !dbg !224
  %26 = bitcast i8* %25 to <16 x i8>*, !dbg !224
  %wide.load435 = load <16 x i8>* %26, align 1, !dbg !224
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !224
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !224
  %27 = getelementptr i8* %dst, i64 %next.gep236.sum, !dbg !224
  %28 = bitcast i8* %27 to <16 x i8>*, !dbg !224
  store <16 x i8> %reverse437, <16 x i8>* %28, align 1, !dbg !224
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !224
  %29 = getelementptr i8* %dst, i64 %.sum505, !dbg !224
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !224
  store <16 x i8> %reverse438, <16 x i8>* %30, align 1, !dbg !224
  %index.next234 = add i64 %index212, 32
  %31 = icmp eq i64 %index.next234, %n.vec215
  br i1 %31, label %middle.block210, label %vector.body209, !llvm.loop !226

middle.block210:                                  ; preds = %vector.body209, %vector.memcheck224, %.lr.ph9
  %resume.val225 = phi i8* [ %21, %.lr.ph9 ], [ %21, %vector.memcheck224 ], [ %rev.ptr.ind.end, %vector.body209 ]
  %resume.val227 = phi i8* [ %22, %.lr.ph9 ], [ %22, %vector.memcheck224 ], [ %rev.ptr.ind.end229, %vector.body209 ]
  %resume.val230 = phi i64 [ %count, %.lr.ph9 ], [ %count, %vector.memcheck224 ], [ %rev.ind.end231, %vector.body209 ]
  %new.indc.resume.val232 = phi i64 [ 0, %.lr.ph9 ], [ 0, %vector.memcheck224 ], [ %n.vec215, %vector.body209 ]
  %cmp.n233 = icmp eq i64 %new.indc.resume.val232, %count
  br i1 %cmp.n233, label %.loopexit, label %scalar.ph211

scalar.ph211:                                     ; preds = %scalar.ph211, %middle.block210
  %b.18 = phi i8* [ %33, %scalar.ph211 ], [ %resume.val225, %middle.block210 ]
  %a.17 = phi i8* [ %35, %scalar.ph211 ], [ %resume.val227, %middle.block210 ]
  %.16 = phi i64 [ %32, %scalar.ph211 ], [ %resume.val230, %middle.block210 ]
  %32 = add i64 %.16, -1, !dbg !224
  %33 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !224
  %34 = load i8* %b.18, align 1, !dbg !224, !tbaa !211
  %35 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !224
  store i8 %34, i8* %a.17, align 1, !dbg !224, !tbaa !211
  %36 = icmp eq i64 %32, 0, !dbg !224
  br i1 %36, label %.loopexit, label %scalar.ph211, !dbg !224, !llvm.loop !227

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !228
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !229
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !229

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep5 = getelementptr i8* %srcaddr, i64 %2
  %scevgep4 = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep4, %srcaddr
  %bound0 = icmp uge i8* %scevgep5, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end7 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep104 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !230
  %wide.load = load <16 x i8>* %3, align 1, !dbg !230
  %next.gep.sum280 = or i64 %index, 16, !dbg !230
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !230
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !230
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !230
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !230
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !230
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum280, !dbg !230
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !230
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !230
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !231

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val6 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end7, %vector.body ]
  %resume.val8 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val6, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val8, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !229
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !230
  %12 = load i8* %src.03, align 1, !dbg !230, !tbaa !211
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !230
  store i8 %12, i8* %dest.02, align 1, !dbg !230, !tbaa !211
  %14 = icmp eq i64 %10, 0, !dbg !229
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !229, !llvm.loop !232

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !229

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !233
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
  %1 = icmp eq i64 %count, 0, !dbg !234
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !234

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !235
  br label %3, !dbg !234

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !234
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !235
  store volatile i8 %2, i8* %a.02, align 1, !dbg !235, !tbaa !211
  %6 = icmp eq i64 %4, 0, !dbg !234
  br i1 %6, label %._crit_edge, label %3, !dbg !234

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !236
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { nobuiltin nounwind }
attributes #9 = { nobuiltin noreturn nounwind }

!llvm.dbg.cu = !{!0, !23, !36, !47, !61, !73, !86, !105, !120, !135}
!llvm.module.flags = !{!151, !152}
!llvm.ident = !{!153, !153, !153, !153, !153, !153, !153, !153, !153, !153}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG
!1 = metadata !{metadata !"point_struct.c", metadata !"/home/ubuntu/function_pointer"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !9, metadata !20}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"add", metadata !"add", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @add, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogra
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/ubuntu/function_pointer/point_struct.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"bar", metadata !"bar", metadata !"", i32 18, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (%struct.foo*)* @bar, null, null, metadata !2, i32 18} ; [ DW_TAG_su
!10 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !11, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!11 = metadata !{metadata !8, metadata !12}
!12 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from foo]
!13 = metadata !{i32 786451, metadata !1, null, metadata !"foo", i32 12, i64 128, i64 64, i32 0, i32 0, null, metadata !14, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [foo] [line 12, size 128, align 64, offset 0] [def] [from ]
!14 = metadata !{metadata !15, metadata !16, metadata !17}
!15 = metadata !{i32 786445, metadata !1, metadata !13, metadata !"foo1", i32 13, i64 32, i64 32, i64 0, i32 0, metadata !8} ; [ DW_TAG_member ] [foo1] [line 13, size 32, align 32, offset 0] [from int]
!16 = metadata !{i32 786445, metadata !1, metadata !13, metadata !"foo2", i32 14, i64 32, i64 32, i64 32, i32 0, metadata !8} ; [ DW_TAG_member ] [foo2] [line 14, size 32, align 32, offset 32] [from int]
!17 = metadata !{i32 786445, metadata !1, metadata !13, metadata !"func_pointer", i32 15, i64 64, i64 64, i64 64, i32 0, metadata !18} ; [ DW_TAG_member ] [func_pointer] [line 15, size 64, align 64, offset 64] [from function]
!18 = metadata !{i32 786454, metadata !1, null, metadata !"function", i32 10, i64 0, i64 0, i64 0, i32 0, metadata !19} ; [ DW_TAG_typedef ] [function] [line 10, size 0, align 0, offset 0] [from ]
!19 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !6} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!20 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 32, metadata !21, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 32} ; [ DW_TAG_subprogram ]
!21 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !22, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!22 = metadata !{metadata !8}
!23 = metadata !{i32 786449, metadata !24, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !25, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!24 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!25 = metadata !{metadata !26}
!26 = metadata !{i32 786478, metadata !27, metadata !28, metadata !"klee_choose", metadata !"klee_choose", metadata !"", i32 12, metadata !29, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i64)* @klee_choose, null, null, metadata !33, i32
!27 = metadata !{metadata !"klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!28 = metadata !{i32 786473, metadata !27}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!29 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !30, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!30 = metadata !{metadata !31, metadata !31}
!31 = metadata !{i32 786454, metadata !27, null, metadata !"uintptr_t", i32 122, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ] [uintptr_t] [line 122, size 0, align 0, offset 0] [from long unsigned int]
!32 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!33 = metadata !{metadata !34, metadata !35}
!34 = metadata !{i32 786689, metadata !26, metadata !"n", metadata !28, i32 16777228, metadata !31, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 12]
!35 = metadata !{i32 786688, metadata !26, metadata !"x", metadata !28, i32 13, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 13]
!36 = metadata !{i32 786449, metadata !37, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !38, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!37 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!38 = metadata !{metadata !39}
!39 = metadata !{i32 786478, metadata !40, metadata !41, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !42, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!40 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!41 = metadata !{i32 786473, metadata !40}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!42 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !43, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!43 = metadata !{null, metadata !44}
!44 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!45 = metadata !{metadata !46}
!46 = metadata !{i32 786689, metadata !39, metadata !"z", metadata !41, i32 16777228, metadata !44, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!47 = metadata !{i32 786449, metadata !48, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !49, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!48 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!49 = metadata !{metadata !50}
!50 = metadata !{i32 786478, metadata !51, metadata !52, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !53, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !58, i32 13} ; [ 
!51 = metadata !{metadata !"klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!52 = metadata !{i32 786473, metadata !51}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_int.c]
!53 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !54, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!54 = metadata !{metadata !8, metadata !55}
!55 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !56} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!56 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !57} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!57 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!58 = metadata !{metadata !59, metadata !60}
!59 = metadata !{i32 786689, metadata !50, metadata !"name", metadata !52, i32 16777229, metadata !55, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!60 = metadata !{i32 786688, metadata !50, metadata !"x", metadata !52, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!61 = metadata !{i32 786449, metadata !62, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !63, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!62 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!63 = metadata !{metadata !64}
!64 = metadata !{i32 786478, metadata !65, metadata !66, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !67, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!65 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!66 = metadata !{i32 786473, metadata !65}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!67 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !68, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!68 = metadata !{null, metadata !69, metadata !69}
!69 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!70 = metadata !{metadata !71, metadata !72}
!71 = metadata !{i32 786689, metadata !64, metadata !"bitWidth", metadata !66, i32 16777236, metadata !69, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!72 = metadata !{i32 786689, metadata !64, metadata !"shift", metadata !66, i32 33554452, metadata !69, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!73 = metadata !{i32 786449, metadata !74, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !75, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!74 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!75 = metadata !{metadata !76}
!76 = metadata !{i32 786478, metadata !77, metadata !78, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !79, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!77 = metadata !{metadata !"klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!78 = metadata !{i32 786473, metadata !77}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!79 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !80, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!80 = metadata !{metadata !8, metadata !8, metadata !8, metadata !55}
!81 = metadata !{metadata !82, metadata !83, metadata !84, metadata !85}
!82 = metadata !{i32 786689, metadata !76, metadata !"start", metadata !78, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!83 = metadata !{i32 786689, metadata !76, metadata !"end", metadata !78, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!84 = metadata !{i32 786689, metadata !76, metadata !"name", metadata !78, i32 50331661, metadata !55, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!85 = metadata !{i32 786688, metadata !76, metadata !"x", metadata !78, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!86 = metadata !{i32 786449, metadata !87, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !88, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!87 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!88 = metadata !{metadata !89}
!89 = metadata !{i32 786478, metadata !90, metadata !91, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !92, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !98, i32 12} 
!90 = metadata !{metadata !"memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!91 = metadata !{i32 786473, metadata !90}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memcpy.c]
!92 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !93, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!93 = metadata !{metadata !94, metadata !94, metadata !95, metadata !97}
!94 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!95 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !96} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!96 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!97 = metadata !{i32 786454, metadata !90, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!98 = metadata !{metadata !99, metadata !100, metadata !101, metadata !102, metadata !104}
!99 = metadata !{i32 786689, metadata !89, metadata !"destaddr", metadata !91, i32 16777228, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!100 = metadata !{i32 786689, metadata !89, metadata !"srcaddr", metadata !91, i32 33554444, metadata !95, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!101 = metadata !{i32 786689, metadata !89, metadata !"len", metadata !91, i32 50331660, metadata !97, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!102 = metadata !{i32 786688, metadata !89, metadata !"dest", metadata !91, i32 13, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!103 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !57} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!104 = metadata !{i32 786688, metadata !89, metadata !"src", metadata !91, i32 14, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!105 = metadata !{i32 786449, metadata !106, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !107, metadata !2, metadata !2, metadata !""} ; [ DW
!106 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!107 = metadata !{metadata !108}
!108 = metadata !{i32 786478, metadata !109, metadata !110, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !111, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !114, 
!109 = metadata !{metadata !"memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!110 = metadata !{i32 786473, metadata !109}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!111 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !112, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!112 = metadata !{metadata !94, metadata !94, metadata !95, metadata !113}
!113 = metadata !{i32 786454, metadata !109, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!114 = metadata !{metadata !115, metadata !116, metadata !117, metadata !118, metadata !119}
!115 = metadata !{i32 786689, metadata !108, metadata !"dst", metadata !110, i32 16777228, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!116 = metadata !{i32 786689, metadata !108, metadata !"src", metadata !110, i32 33554444, metadata !95, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!117 = metadata !{i32 786689, metadata !108, metadata !"count", metadata !110, i32 50331660, metadata !113, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!118 = metadata !{i32 786688, metadata !108, metadata !"a", metadata !110, i32 13, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!119 = metadata !{i32 786688, metadata !108, metadata !"b", metadata !110, i32 14, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!120 = metadata !{i32 786449, metadata !121, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !122, metadata !2, metadata !2, metadata !""} ; [ DW
!121 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!122 = metadata !{metadata !123}
!123 = metadata !{i32 786478, metadata !124, metadata !125, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !126, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !129, 
!124 = metadata !{metadata !"mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!125 = metadata !{i32 786473, metadata !124}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c]
!126 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !127, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!127 = metadata !{metadata !94, metadata !94, metadata !95, metadata !128}
!128 = metadata !{i32 786454, metadata !124, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!129 = metadata !{metadata !130, metadata !131, metadata !132, metadata !133, metadata !134}
!130 = metadata !{i32 786689, metadata !123, metadata !"destaddr", metadata !125, i32 16777227, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!131 = metadata !{i32 786689, metadata !123, metadata !"srcaddr", metadata !125, i32 33554443, metadata !95, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!132 = metadata !{i32 786689, metadata !123, metadata !"len", metadata !125, i32 50331659, metadata !128, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!133 = metadata !{i32 786688, metadata !123, metadata !"dest", metadata !125, i32 12, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!134 = metadata !{i32 786688, metadata !123, metadata !"src", metadata !125, i32 13, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!135 = metadata !{i32 786449, metadata !136, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !137, metadata !2, metadata !2, metadata !""} ; [ DW
!136 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!137 = metadata !{metadata !138}
!138 = metadata !{i32 786478, metadata !139, metadata !140, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !141, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !144, i32
!139 = metadata !{metadata !"memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!140 = metadata !{i32 786473, metadata !139}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memset.c]
!141 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !142, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!142 = metadata !{metadata !94, metadata !94, metadata !8, metadata !143}
!143 = metadata !{i32 786454, metadata !139, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!144 = metadata !{metadata !145, metadata !146, metadata !147, metadata !148}
!145 = metadata !{i32 786689, metadata !138, metadata !"dst", metadata !140, i32 16777227, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!146 = metadata !{i32 786689, metadata !138, metadata !"s", metadata !140, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!147 = metadata !{i32 786689, metadata !138, metadata !"count", metadata !140, i32 50331659, metadata !143, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!148 = metadata !{i32 786688, metadata !138, metadata !"a", metadata !140, i32 12, metadata !149, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!149 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !150} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!150 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !57} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!151 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!152 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!153 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!154 = metadata !{i32 7, i32 0, metadata !4, null}
!155 = metadata !{i32 20, i32 0, metadata !9, null}
!156 = metadata !{i32 21, i32 0, metadata !9, null}
!157 = metadata !{i32 23, i32 0, metadata !158, null}
!158 = metadata !{i32 786443, metadata !1, metadata !9, i32 23, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/function_pointer/point_struct.c]
!159 = metadata !{i32 24, i32 0, metadata !160, null}
!160 = metadata !{i32 786443, metadata !1, metadata !158, i32 23, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/function_pointer/point_struct.c]
!161 = metadata !{i32 27, i32 0, metadata !162, null}
!162 = metadata !{i32 786443, metadata !1, metadata !158, i32 26, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/function_pointer/point_struct.c]
!163 = metadata !{i32 29, i32 0, metadata !9, null}
!164 = metadata !{i32 33, i32 0, metadata !20, null}
!165 = metadata !{i32 35, i32 0, metadata !20, null}
!166 = metadata !{i32 36, i32 0, metadata !20, null}
!167 = metadata !{i32 14, i32 0, metadata !26, null}
!168 = metadata !{i32 17, i32 0, metadata !169, null}
!169 = metadata !{i32 786443, metadata !27, metadata !26, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!170 = metadata !{metadata !171, metadata !171, i64 0}
!171 = metadata !{metadata !"long", metadata !172, i64 0}
!172 = metadata !{metadata !"omnipotent char", metadata !173, i64 0}
!173 = metadata !{metadata !"Simple C/C++ TBAA"}
!174 = metadata !{i32 18, i32 0, metadata !169, null}
!175 = metadata !{i32 19, i32 0, metadata !26, null}
!176 = metadata !{i32 13, i32 0, metadata !177, null}
!177 = metadata !{i32 786443, metadata !40, metadata !39, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!178 = metadata !{i32 14, i32 0, metadata !177, null}
!179 = metadata !{i32 15, i32 0, metadata !39, null}
!180 = metadata !{i32 15, i32 0, metadata !50, null}
!181 = metadata !{i32 16, i32 0, metadata !50, null}
!182 = metadata !{metadata !183, metadata !183, i64 0}
!183 = metadata !{metadata !"int", metadata !172, i64 0}
!184 = metadata !{i32 21, i32 0, metadata !185, null}
!185 = metadata !{i32 786443, metadata !65, metadata !64, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!186 = metadata !{i32 27, i32 0, metadata !187, null}
!187 = metadata !{i32 786443, metadata !65, metadata !185, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!188 = metadata !{i32 29, i32 0, metadata !64, null}
!189 = metadata !{i32 16, i32 0, metadata !190, null}
!190 = metadata !{i32 786443, metadata !77, metadata !76, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!191 = metadata !{i32 17, i32 0, metadata !190, null}
!192 = metadata !{i32 19, i32 0, metadata !193, null}
!193 = metadata !{i32 786443, metadata !77, metadata !76, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!194 = metadata !{i32 22, i32 0, metadata !195, null}
!195 = metadata !{i32 786443, metadata !77, metadata !193, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!196 = metadata !{i32 25, i32 0, metadata !197, null}
!197 = metadata !{i32 786443, metadata !77, metadata !195, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!198 = metadata !{i32 26, i32 0, metadata !199, null}
!199 = metadata !{i32 786443, metadata !77, metadata !197, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!200 = metadata !{i32 27, i32 0, metadata !199, null}
!201 = metadata !{i32 28, i32 0, metadata !202, null}
!202 = metadata !{i32 786443, metadata !77, metadata !197, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!203 = metadata !{i32 29, i32 0, metadata !202, null}
!204 = metadata !{i32 32, i32 0, metadata !195, null}
!205 = metadata !{i32 34, i32 0, metadata !76, null}
!206 = metadata !{i32 16, i32 0, metadata !89, null}
!207 = metadata !{i32 17, i32 0, metadata !89, null}
!208 = metadata !{metadata !208, metadata !209, metadata !210}
!209 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!210 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!211 = metadata !{metadata !172, metadata !172, i64 0}
!212 = metadata !{metadata !212, metadata !209, metadata !210}
!213 = metadata !{i32 18, i32 0, metadata !89, null}
!214 = metadata !{i32 16, i32 0, metadata !215, null}
!215 = metadata !{i32 786443, metadata !109, metadata !108, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!216 = metadata !{i32 19, i32 0, metadata !217, null}
!217 = metadata !{i32 786443, metadata !109, metadata !108, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!218 = metadata !{i32 20, i32 0, metadata !219, null}
!219 = metadata !{i32 786443, metadata !109, metadata !217, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!220 = metadata !{metadata !220, metadata !209, metadata !210}
!221 = metadata !{metadata !221, metadata !209, metadata !210}
!222 = metadata !{i32 22, i32 0, metadata !223, null}
!223 = metadata !{i32 786443, metadata !109, metadata !217, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!224 = metadata !{i32 24, i32 0, metadata !223, null}
!225 = metadata !{i32 23, i32 0, metadata !223, null}
!226 = metadata !{metadata !226, metadata !209, metadata !210}
!227 = metadata !{metadata !227, metadata !209, metadata !210}
!228 = metadata !{i32 28, i32 0, metadata !108, null}
!229 = metadata !{i32 15, i32 0, metadata !123, null}
!230 = metadata !{i32 16, i32 0, metadata !123, null}
!231 = metadata !{metadata !231, metadata !209, metadata !210}
!232 = metadata !{metadata !232, metadata !209, metadata !210}
!233 = metadata !{i32 17, i32 0, metadata !123, null}
!234 = metadata !{i32 13, i32 0, metadata !138, null}
!235 = metadata !{i32 14, i32 0, metadata !138, null}
!236 = metadata !{i32 15, i32 0, metadata !138, null}
