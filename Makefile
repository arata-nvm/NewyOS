newyos.img : ipl.bin
	mformat -f 1440 -C -B ipl.bin -i newyos.img

ipl.bin : newyos.nas
	nasm newyos.nas -o ipl.bin

run :
	qemu-system-i386 -fda newyos.img -boot a

.PHONY : clean
clean :
	-rm -f newyos.img ipl.bin