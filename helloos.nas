; newy-os
; TAB=4

    ORG     0x7c00          ; プログラムがどこに読み込まれるか  

; FAT12フォーマット

    JMP     entry
    DB      0x90
    DB      "NEWYIPL "      ; ブートセクタの名前(8バイト)
    DW      512             ; 1セクタの大きさ
    DB      1               ; クラスタの大きさ
    DW      1               ; FATの開始位置
    DB      2               ; FATの個数
    DW      224             ; ルートディレクトリ領域の大きさ
    DW      2880            ; ドライブの大きさ
    DB      0xf0            ; メディアのタイプ
    DW      9               ; FAT領域の長さ
    DW      18              ; 1トラック中のセクタ数
    DW      2               ; ヘッド数
    DD      0               ; パーティションの数
    DD      2880            ; ドライブの大きさ
    DB      0, 0, 0x29      ; 不明
    DD      0xffffffff      ; ボリュームシリアル番号
    DB      "NEWY-OS    "   ; ディスク名
    DB      "FAT12   "      ; フォーマット名
    RESB    18              ; 18バイト空ける

; プログラム本体

entry:
    ; レジスタの初期化
    MOV     AX, 0
    MOV     SS, AX
    MOV     SP, 0x7c00
    MOV     DS, AX
    MOV     ES, AX

    MOV     SI, msg

putloop:
    MOV     AL, [SI]
    ADD     SI, 1           ; SIに1を足す
    CMP     AL, 0
    JE      fin
    MOV     AH, 0x0e        ; 一文字表示
    MOV     BX, 15          ; カラーコード
    INT     0x10            ; ビデオBIOS呼び出し
    JMP     putloop

fin:
    HLT                     ; 何かあるまでCPUを停止させる
    JMP fin                 ; 無限ループ

msg:

    DB      0x0a, 0x0a      ; 改行2つ
    DB      "hello, world"  
    DB      0x0a            ; 改行
    DB      0

    RESB    0x1fe-($-$$)         ; 0x001feまでを0x00で埋める

    DB      0x55, 0xaa

; ブートセクタ以外の部分

	DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
	RESB	4600
	DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
	RESB	1469432
