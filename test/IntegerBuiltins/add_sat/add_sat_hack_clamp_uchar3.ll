
; RUN: clspv-opt -ReplaceOpenCLBuiltin -hack-clamp-width %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by add_sat_hack_clamp_test_gen.cpp.
; Please modify the that file and regenerate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

define <3 x i8> @add_sat_uchar3(<3 x i8> %a, <3 x i8> %b) {
entry:
 %call = call <3 x i8> @_Z7add_satDv3_hS_(<3 x i8> %a, <3 x i8> %b)
 ret <3 x i8> %call
}

declare <3 x i8> @_Z7add_satDv3_hS_(<3 x i8>, <3 x i8>)

; CHECK: [[call:%[a-zA-Z0-9_.]+]] = call { <3 x i8>, <3 x i8> } @_Z8spirv.op.149.Dv3_hDv3_h(i32 149, <3 x i8> %a, <3 x i8> %b)
; CHECK: [[ex0:%[a-zA-Z0-9_.]+]] = extractvalue { <3 x i8>, <3 x i8> } [[call]], 0
; CHECK: [[ex1:%[a-zA-Z0-9_.]+]] = extractvalue { <3 x i8>, <3 x i8> } [[call]], 1
; CHECK: [[cmp:%[a-zA-Z0-9_.]+]] = icmp eq <3 x i8> [[ex1]], zeroinitializer
; CHECK: [[sel:%[a-zA-Z0-9_.]+]] = select <3 x i1> [[cmp]], <3 x i8> [[ex0]], <3 x i8> <i8 -1, i8 -1, i8 -1>
; CHECK: ret <3 x i8> [[sel]]
