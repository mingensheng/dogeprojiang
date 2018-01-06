; ModuleID = 'point_struct.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.foo = type { i32, i32 }

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
define i32 @bar(%struct.foo* %foo_ptr) #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.foo*, align 8
  store %struct.foo* %foo_ptr, %struct.foo** %2, align 8
  %3 = load %struct.foo** %2, align 8, !dbg !148
  %4 = getelementptr inbounds %struct.foo* %3, i32 0, i32 0, !dbg !148
  %5 = load i32* %4, align 4, !dbg !148
  %6 = icmp eq i32 %5, 1, !dbg !148
  br i1 %6, label %7, label %8, !dbg !148

; <label>:7                                       ; preds = %0
  store i32 1, i32* %1, !dbg !150
  br label %9, !dbg !150

; <label>:8                                       ; preds = %0
  store i32 2, i32* %1, !dbg !152
  br label %9, !dbg !152

; <label>:9                                       ; preds = %8, %7
  %10 = load i32* %1, !dbg !154
  ret i32 %10, !dbg !154
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %foo_ptr = alloca %struct.foo*, align 8
  %1 = call noalias i8* @malloc(i64 8) #7, !dbg !155
  %2 = bitcast i8* %1 to %struct.foo*, !dbg !155
  store %struct.foo* %2, %struct.foo** %foo_ptr, align 8, !dbg !155
  %3 = bitcast %struct.foo** %foo_ptr to i8*, !dbg !156
  call void @klee_make_symbolic(i8* %3, i64 8, i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)), !dbg !156
  %4 = load %struct.foo** %foo_ptr, align 8, !dbg !157
  %5 = call i32 @bar(%struct.foo* %4), !dbg !157
  ret i32 0, !dbg !158
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

declare void @klee_make_symbolic(i8*, i64, i8*) #3

; Function Attrs: nounwind ssp uwtable
define i64 @klee_choose(i64 %n) #4 {
  %x = alloca i64, align 8
  %1 = bitcast i64* %x to i8*, !dbg !159
  call void @klee_make_symbolic(i8* %1, i64 8, i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0)) #8, !dbg !159
  %2 = load i64* %x, align 8, !dbg !160, !tbaa !162
  %3 = icmp ult i64 %2, %n, !dbg !160
  br i1 %3, label %5, label %4, !dbg !160

; <label>:4                                       ; preds = %0
  call void @klee_silent_exit(i32 0) #9, !dbg !166
  unreachable, !dbg !166

; <label>:5                                       ; preds = %0
  ret i64 %2, !dbg !167
}

; Function Attrs: noreturn
declare void @klee_silent_exit(i32) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind ssp uwtable
define void @klee_div_zero_check(i64 %z) #4 {
  %1 = icmp eq i64 %z, 0, !dbg !168
  br i1 %1, label %2, label %3, !dbg !168

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str12, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str123, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #9, !dbg !170
  unreachable, !dbg !170

; <label>:3                                       ; preds = %0
  ret void, !dbg !171
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind ssp uwtable
define i32 @klee_int(i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !172
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #8, !dbg !172
  %2 = load i32* %x, align 4, !dbg !173, !tbaa !174
  ret i32 %2, !dbg !173
}

; Function Attrs: nounwind ssp uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !176
  br i1 %1, label %3, label %2, !dbg !176

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #9, !dbg !178
  unreachable, !dbg !178

; <label>:3                                       ; preds = %0
  ret void, !dbg !180
}

; Function Attrs: nounwind ssp uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !181
  br i1 %1, label %3, label %2, !dbg !181

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #9, !dbg !183
  unreachable, !dbg !183

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !184
  %5 = icmp eq i32 %4, %end, !dbg !184
  br i1 %5, label %21, label %6, !dbg !184

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !186
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #8, !dbg !186
  %8 = icmp eq i32 %start, 0, !dbg !188
  %9 = load i32* %x, align 4, !dbg !190, !tbaa !174
  br i1 %8, label %10, label %13, !dbg !188

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !190
  %12 = zext i1 %11 to i64, !dbg !190
  call void @klee_assume(i64 %12) #8, !dbg !190
  br label %19, !dbg !192

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !193
  %15 = zext i1 %14 to i64, !dbg !193
  call void @klee_assume(i64 %15) #8, !dbg !193
  %16 = load i32* %x, align 4, !dbg !195, !tbaa !174
  %17 = icmp slt i32 %16, %end, !dbg !195
  %18 = zext i1 %17 to i64, !dbg !195
  call void @klee_assume(i64 %18) #8, !dbg !195
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !196, !tbaa !174
  br label %21, !dbg !196

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !197
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind ssp uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !198
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !198

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
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !199
  %wide.load = load <16 x i8>* %3, align 1, !dbg !199
  %next.gep.sum279 = or i64 %index, 16, !dbg !199
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !199
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !199
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !199
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !199
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !199
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum279, !dbg !199
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !199
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !199
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !200

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
  %10 = add i64 %.01, -1, !dbg !198
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !199
  %12 = load i8* %src.03, align 1, !dbg !199, !tbaa !203
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !199
  store i8 %12, i8* %dest.02, align 1, !dbg !199, !tbaa !203
  %14 = icmp eq i64 %10, 0, !dbg !198
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !198, !llvm.loop !204

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !205
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
  %1 = icmp eq i8* %src, %dst, !dbg !206
  br i1 %1, label %.loopexit, label %2, !dbg !206

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !208
  br i1 %3, label %.preheader, label %18, !dbg !208

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !210
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !210

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
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !210
  %wide.load = load <16 x i8>* %6, align 1, !dbg !210
  %next.gep.sum586 = or i64 %index, 16, !dbg !210
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !210
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !210
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !210
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !210
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !210
  %10 = getelementptr i8* %dst, i64 %next.gep.sum586, !dbg !210
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !210
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !210
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !212

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
  %13 = add i64 %.02, -1, !dbg !210
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !210
  %15 = load i8* %b.04, align 1, !dbg !210, !tbaa !203
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !210
  store i8 %15, i8* %a.03, align 1, !dbg !210, !tbaa !203
  %17 = icmp eq i64 %13, 0, !dbg !210
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !210, !llvm.loop !213

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !214
  %20 = icmp eq i64 %count, 0, !dbg !216
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !216

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !217
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !214
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
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !216
  %23 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !216
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !216
  %wide.load434 = load <16 x i8>* %24, align 1, !dbg !216
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !216
  %.sum505 = add i64 %.sum440, -31, !dbg !216
  %25 = getelementptr i8* %src, i64 %.sum505, !dbg !216
  %26 = bitcast i8* %25 to <16 x i8>*, !dbg !216
  %wide.load435 = load <16 x i8>* %26, align 1, !dbg !216
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !216
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !216
  %27 = getelementptr i8* %dst, i64 %next.gep236.sum, !dbg !216
  %28 = bitcast i8* %27 to <16 x i8>*, !dbg !216
  store <16 x i8> %reverse437, <16 x i8>* %28, align 1, !dbg !216
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !216
  %29 = getelementptr i8* %dst, i64 %.sum505, !dbg !216
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !216
  store <16 x i8> %reverse438, <16 x i8>* %30, align 1, !dbg !216
  %index.next234 = add i64 %index212, 32
  %31 = icmp eq i64 %index.next234, %n.vec215
  br i1 %31, label %middle.block210, label %vector.body209, !llvm.loop !218

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
  %32 = add i64 %.16, -1, !dbg !216
  %33 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !216
  %34 = load i8* %b.18, align 1, !dbg !216, !tbaa !203
  %35 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !216
  store i8 %34, i8* %a.17, align 1, !dbg !216, !tbaa !203
  %36 = icmp eq i64 %32, 0, !dbg !216
  br i1 %36, label %.loopexit, label %scalar.ph211, !dbg !216, !llvm.loop !219

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !220
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !221
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !221

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
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !222
  %wide.load = load <16 x i8>* %3, align 1, !dbg !222
  %next.gep.sum280 = or i64 %index, 16, !dbg !222
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !222
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !222
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !222
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !222
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !222
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum280, !dbg !222
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !222
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !222
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !223

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
  %10 = add i64 %.01, -1, !dbg !221
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !222
  %12 = load i8* %src.03, align 1, !dbg !222, !tbaa !203
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !222
  store i8 %12, i8* %dest.02, align 1, !dbg !222, !tbaa !203
  %14 = icmp eq i64 %10, 0, !dbg !221
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !221, !llvm.loop !224

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !221

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !225
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
  %1 = icmp eq i64 %count, 0, !dbg !226
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !226

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !227
  br label %3, !dbg !226

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !226
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !227
  store volatile i8 %2, i8* %a.02, align 1, !dbg !227, !tbaa !203
  %6 = icmp eq i64 %4, 0, !dbg !226
  br i1 %6, label %._crit_edge, label %3, !dbg !226

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !228
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

!llvm.dbg.cu = !{!0, !17, !30, !41, !55, !67, !80, !99, !114, !129}
!llvm.module.flags = !{!145, !146}
!llvm.ident = !{!147, !147, !147, !147, !147, !147, !147, !147, !147, !147}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG
!1 = metadata !{metadata !"point_struct.c", metadata !"/home/ubuntu/test_pointer"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !14}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"bar", metadata !"bar", metadata !"", i32 10, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (%struct.foo*)* @bar, null, null, metadata !2, i32 10} ; [ DW_TAG_sub
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/ubuntu/test_pointer/point_struct.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !9}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from foo]
!10 = metadata !{i32 786451, metadata !1, null, metadata !"foo", i32 4, i64 64, i64 32, i32 0, i32 0, null, metadata !11, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [foo] [line 4, size 64, align 32, offset 0] [def] [from ]
!11 = metadata !{metadata !12, metadata !13}
!12 = metadata !{i32 786445, metadata !1, metadata !10, metadata !"foo1", i32 5, i64 32, i64 32, i64 0, i32 0, metadata !8} ; [ DW_TAG_member ] [foo1] [line 5, size 32, align 32, offset 0] [from int]
!13 = metadata !{i32 786445, metadata !1, metadata !10, metadata !"foo2", i32 6, i64 32, i64 32, i64 32, i32 0, metadata !8} ; [ DW_TAG_member ] [foo2] [line 6, size 32, align 32, offset 32] [from int]
!14 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 21, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 21} ; [ DW_TAG_subprogram ]
!15 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{metadata !8}
!17 = metadata !{i32 786449, metadata !18, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !19, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!18 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!19 = metadata !{metadata !20}
!20 = metadata !{i32 786478, metadata !21, metadata !22, metadata !"klee_choose", metadata !"klee_choose", metadata !"", i32 12, metadata !23, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i64)* @klee_choose, null, null, metadata !27, i32
!21 = metadata !{metadata !"klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!22 = metadata !{i32 786473, metadata !21}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!23 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !24, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!24 = metadata !{metadata !25, metadata !25}
!25 = metadata !{i32 786454, metadata !21, null, metadata !"uintptr_t", i32 122, i64 0, i64 0, i64 0, i32 0, metadata !26} ; [ DW_TAG_typedef ] [uintptr_t] [line 122, size 0, align 0, offset 0] [from long unsigned int]
!26 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!27 = metadata !{metadata !28, metadata !29}
!28 = metadata !{i32 786689, metadata !20, metadata !"n", metadata !22, i32 16777228, metadata !25, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 12]
!29 = metadata !{i32 786688, metadata !20, metadata !"x", metadata !22, i32 13, metadata !25, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 13]
!30 = metadata !{i32 786449, metadata !31, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !32, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!31 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!32 = metadata !{metadata !33}
!33 = metadata !{i32 786478, metadata !34, metadata !35, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !36, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!34 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!35 = metadata !{i32 786473, metadata !34}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!36 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !37, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!37 = metadata !{null, metadata !38}
!38 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!39 = metadata !{metadata !40}
!40 = metadata !{i32 786689, metadata !33, metadata !"z", metadata !35, i32 16777228, metadata !38, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!41 = metadata !{i32 786449, metadata !42, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !43, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!42 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!43 = metadata !{metadata !44}
!44 = metadata !{i32 786478, metadata !45, metadata !46, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !47, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !52, i32 13} ; [ 
!45 = metadata !{metadata !"klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!46 = metadata !{i32 786473, metadata !45}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_int.c]
!47 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !48, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!48 = metadata !{metadata !8, metadata !49}
!49 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !50} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!50 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !51} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!51 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!52 = metadata !{metadata !53, metadata !54}
!53 = metadata !{i32 786689, metadata !44, metadata !"name", metadata !46, i32 16777229, metadata !49, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!54 = metadata !{i32 786688, metadata !44, metadata !"x", metadata !46, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!55 = metadata !{i32 786449, metadata !56, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !57, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!56 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!57 = metadata !{metadata !58}
!58 = metadata !{i32 786478, metadata !59, metadata !60, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !61, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!59 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!60 = metadata !{i32 786473, metadata !59}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!61 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !62, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!62 = metadata !{null, metadata !63, metadata !63}
!63 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!64 = metadata !{metadata !65, metadata !66}
!65 = metadata !{i32 786689, metadata !58, metadata !"bitWidth", metadata !60, i32 16777236, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!66 = metadata !{i32 786689, metadata !58, metadata !"shift", metadata !60, i32 33554452, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!67 = metadata !{i32 786449, metadata !68, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !69, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!68 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!69 = metadata !{metadata !70}
!70 = metadata !{i32 786478, metadata !71, metadata !72, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !73, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!71 = metadata !{metadata !"klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!72 = metadata !{i32 786473, metadata !71}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!73 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !74, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!74 = metadata !{metadata !8, metadata !8, metadata !8, metadata !49}
!75 = metadata !{metadata !76, metadata !77, metadata !78, metadata !79}
!76 = metadata !{i32 786689, metadata !70, metadata !"start", metadata !72, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!77 = metadata !{i32 786689, metadata !70, metadata !"end", metadata !72, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!78 = metadata !{i32 786689, metadata !70, metadata !"name", metadata !72, i32 50331661, metadata !49, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!79 = metadata !{i32 786688, metadata !70, metadata !"x", metadata !72, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!80 = metadata !{i32 786449, metadata !81, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !82, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!81 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!82 = metadata !{metadata !83}
!83 = metadata !{i32 786478, metadata !84, metadata !85, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !86, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !92, i32 12} 
!84 = metadata !{metadata !"memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!85 = metadata !{i32 786473, metadata !84}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memcpy.c]
!86 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !87, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!87 = metadata !{metadata !88, metadata !88, metadata !89, metadata !91}
!88 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!89 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !90} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!90 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!91 = metadata !{i32 786454, metadata !84, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !26} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!92 = metadata !{metadata !93, metadata !94, metadata !95, metadata !96, metadata !98}
!93 = metadata !{i32 786689, metadata !83, metadata !"destaddr", metadata !85, i32 16777228, metadata !88, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!94 = metadata !{i32 786689, metadata !83, metadata !"srcaddr", metadata !85, i32 33554444, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!95 = metadata !{i32 786689, metadata !83, metadata !"len", metadata !85, i32 50331660, metadata !91, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!96 = metadata !{i32 786688, metadata !83, metadata !"dest", metadata !85, i32 13, metadata !97, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!97 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !51} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!98 = metadata !{i32 786688, metadata !83, metadata !"src", metadata !85, i32 14, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!99 = metadata !{i32 786449, metadata !100, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !101, metadata !2, metadata !2, metadata !""} ; [ DW_
!100 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!101 = metadata !{metadata !102}
!102 = metadata !{i32 786478, metadata !103, metadata !104, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !105, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !108, 
!103 = metadata !{metadata !"memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!104 = metadata !{i32 786473, metadata !103}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!105 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !106, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!106 = metadata !{metadata !88, metadata !88, metadata !89, metadata !107}
!107 = metadata !{i32 786454, metadata !103, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !26} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!108 = metadata !{metadata !109, metadata !110, metadata !111, metadata !112, metadata !113}
!109 = metadata !{i32 786689, metadata !102, metadata !"dst", metadata !104, i32 16777228, metadata !88, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!110 = metadata !{i32 786689, metadata !102, metadata !"src", metadata !104, i32 33554444, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!111 = metadata !{i32 786689, metadata !102, metadata !"count", metadata !104, i32 50331660, metadata !107, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!112 = metadata !{i32 786688, metadata !102, metadata !"a", metadata !104, i32 13, metadata !97, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!113 = metadata !{i32 786688, metadata !102, metadata !"b", metadata !104, i32 14, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!114 = metadata !{i32 786449, metadata !115, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !116, metadata !2, metadata !2, metadata !""} ; [ DW
!115 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!116 = metadata !{metadata !117}
!117 = metadata !{i32 786478, metadata !118, metadata !119, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !120, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !123, 
!118 = metadata !{metadata !"mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!119 = metadata !{i32 786473, metadata !118}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c]
!120 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !121, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!121 = metadata !{metadata !88, metadata !88, metadata !89, metadata !122}
!122 = metadata !{i32 786454, metadata !118, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !26} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!123 = metadata !{metadata !124, metadata !125, metadata !126, metadata !127, metadata !128}
!124 = metadata !{i32 786689, metadata !117, metadata !"destaddr", metadata !119, i32 16777227, metadata !88, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!125 = metadata !{i32 786689, metadata !117, metadata !"srcaddr", metadata !119, i32 33554443, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!126 = metadata !{i32 786689, metadata !117, metadata !"len", metadata !119, i32 50331659, metadata !122, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!127 = metadata !{i32 786688, metadata !117, metadata !"dest", metadata !119, i32 12, metadata !97, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!128 = metadata !{i32 786688, metadata !117, metadata !"src", metadata !119, i32 13, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!129 = metadata !{i32 786449, metadata !130, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !131, metadata !2, metadata !2, metadata !""} ; [ DW
!130 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!131 = metadata !{metadata !132}
!132 = metadata !{i32 786478, metadata !133, metadata !134, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !135, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !138, i32
!133 = metadata !{metadata !"memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!134 = metadata !{i32 786473, metadata !133}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memset.c]
!135 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !136, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!136 = metadata !{metadata !88, metadata !88, metadata !8, metadata !137}
!137 = metadata !{i32 786454, metadata !133, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !26} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!138 = metadata !{metadata !139, metadata !140, metadata !141, metadata !142}
!139 = metadata !{i32 786689, metadata !132, metadata !"dst", metadata !134, i32 16777227, metadata !88, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!140 = metadata !{i32 786689, metadata !132, metadata !"s", metadata !134, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!141 = metadata !{i32 786689, metadata !132, metadata !"count", metadata !134, i32 50331659, metadata !137, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!142 = metadata !{i32 786688, metadata !132, metadata !"a", metadata !134, i32 12, metadata !143, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!143 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !144} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!144 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !51} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!145 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!146 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!147 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!148 = metadata !{i32 12, i32 0, metadata !149, null}
!149 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/test_pointer/point_struct.c]
!150 = metadata !{i32 13, i32 0, metadata !151, null}
!151 = metadata !{i32 786443, metadata !1, metadata !149, i32 12, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/test_pointer/point_struct.c]
!152 = metadata !{i32 16, i32 0, metadata !153, null}
!153 = metadata !{i32 786443, metadata !1, metadata !149, i32 15, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/test_pointer/point_struct.c]
!154 = metadata !{i32 18, i32 0, metadata !4, null}
!155 = metadata !{i32 22, i32 0, metadata !14, null}
!156 = metadata !{i32 23, i32 0, metadata !14, null}
!157 = metadata !{i32 24, i32 0, metadata !14, null}
!158 = metadata !{i32 25, i32 0, metadata !14, null}
!159 = metadata !{i32 14, i32 0, metadata !20, null}
!160 = metadata !{i32 17, i32 0, metadata !161, null}
!161 = metadata !{i32 786443, metadata !21, metadata !20, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!162 = metadata !{metadata !163, metadata !163, i64 0}
!163 = metadata !{metadata !"long", metadata !164, i64 0}
!164 = metadata !{metadata !"omnipotent char", metadata !165, i64 0}
!165 = metadata !{metadata !"Simple C/C++ TBAA"}
!166 = metadata !{i32 18, i32 0, metadata !161, null}
!167 = metadata !{i32 19, i32 0, metadata !20, null}
!168 = metadata !{i32 13, i32 0, metadata !169, null}
!169 = metadata !{i32 786443, metadata !34, metadata !33, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!170 = metadata !{i32 14, i32 0, metadata !169, null}
!171 = metadata !{i32 15, i32 0, metadata !33, null}
!172 = metadata !{i32 15, i32 0, metadata !44, null}
!173 = metadata !{i32 16, i32 0, metadata !44, null}
!174 = metadata !{metadata !175, metadata !175, i64 0}
!175 = metadata !{metadata !"int", metadata !164, i64 0}
!176 = metadata !{i32 21, i32 0, metadata !177, null}
!177 = metadata !{i32 786443, metadata !59, metadata !58, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!178 = metadata !{i32 27, i32 0, metadata !179, null}
!179 = metadata !{i32 786443, metadata !59, metadata !177, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!180 = metadata !{i32 29, i32 0, metadata !58, null}
!181 = metadata !{i32 16, i32 0, metadata !182, null}
!182 = metadata !{i32 786443, metadata !71, metadata !70, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!183 = metadata !{i32 17, i32 0, metadata !182, null}
!184 = metadata !{i32 19, i32 0, metadata !185, null}
!185 = metadata !{i32 786443, metadata !71, metadata !70, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!186 = metadata !{i32 22, i32 0, metadata !187, null}
!187 = metadata !{i32 786443, metadata !71, metadata !185, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!188 = metadata !{i32 25, i32 0, metadata !189, null}
!189 = metadata !{i32 786443, metadata !71, metadata !187, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!190 = metadata !{i32 26, i32 0, metadata !191, null}
!191 = metadata !{i32 786443, metadata !71, metadata !189, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!192 = metadata !{i32 27, i32 0, metadata !191, null}
!193 = metadata !{i32 28, i32 0, metadata !194, null}
!194 = metadata !{i32 786443, metadata !71, metadata !189, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!195 = metadata !{i32 29, i32 0, metadata !194, null}
!196 = metadata !{i32 32, i32 0, metadata !187, null}
!197 = metadata !{i32 34, i32 0, metadata !70, null}
!198 = metadata !{i32 16, i32 0, metadata !83, null}
!199 = metadata !{i32 17, i32 0, metadata !83, null}
!200 = metadata !{metadata !200, metadata !201, metadata !202}
!201 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!202 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!203 = metadata !{metadata !164, metadata !164, i64 0}
!204 = metadata !{metadata !204, metadata !201, metadata !202}
!205 = metadata !{i32 18, i32 0, metadata !83, null}
!206 = metadata !{i32 16, i32 0, metadata !207, null}
!207 = metadata !{i32 786443, metadata !103, metadata !102, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!208 = metadata !{i32 19, i32 0, metadata !209, null}
!209 = metadata !{i32 786443, metadata !103, metadata !102, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!210 = metadata !{i32 20, i32 0, metadata !211, null}
!211 = metadata !{i32 786443, metadata !103, metadata !209, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!212 = metadata !{metadata !212, metadata !201, metadata !202}
!213 = metadata !{metadata !213, metadata !201, metadata !202}
!214 = metadata !{i32 22, i32 0, metadata !215, null}
!215 = metadata !{i32 786443, metadata !103, metadata !209, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!216 = metadata !{i32 24, i32 0, metadata !215, null}
!217 = metadata !{i32 23, i32 0, metadata !215, null}
!218 = metadata !{metadata !218, metadata !201, metadata !202}
!219 = metadata !{metadata !219, metadata !201, metadata !202}
!220 = metadata !{i32 28, i32 0, metadata !102, null}
!221 = metadata !{i32 15, i32 0, metadata !117, null}
!222 = metadata !{i32 16, i32 0, metadata !117, null}
!223 = metadata !{metadata !223, metadata !201, metadata !202}
!224 = metadata !{metadata !224, metadata !201, metadata !202}
!225 = metadata !{i32 17, i32 0, metadata !117, null}
!226 = metadata !{i32 13, i32 0, metadata !132, null}
!227 = metadata !{i32 14, i32 0, metadata !132, null}
!228 = metadata !{i32 15, i32 0, metadata !132, null}
