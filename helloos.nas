; newy-os
; TAB=4

; FAT12フォーマット

    DB      0xeb, 0x4e, 0x90
    DB      "NEWYIPL "       ; ブートセクタの名前(8バイト)
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

	DB		0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
	DB		0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
	DB		0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
	DB		0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
	DB		0xee, 0xf4, 0xeb, 0xfd

; メッセージ部分

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
