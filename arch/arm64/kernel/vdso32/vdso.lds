/* SPDX-License-Identifier: GPL-2.0 */



/* CONFIG_CC_VERSION_TEXT (Do not delete this comment. See help in Kconfig) */


/*
 *
 * Automatically generated file; DO NOT EDIT.
 * Linux/arm64 5.10.160 Kernel Configuration
 *
 */
/*
 * The use of "&&" / "||" is limited in certain expressions.
 * The following enable to calculate "and" / "or" with macro expansion only.
 */
/*
 * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
 * these only work with boolean and tristate options.
 */

/*
 * Getting something that works in C and CPP for an arg that may or may
 * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
 * we match on the placeholder define, insert the "0," for arg1 and generate
 * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
 * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
 * the last step cherry picks the 2nd arg, we get a zero.
 */




/*
 * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
 * otherwise. For boolean options, this is equivalent to
 * IS_ENABLED(CONFIG_FOO).
 */


/*
 * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
 * otherwise.
 */


/*
 * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
 * code can call a function defined in code compiled based on CONFIG_FOO.
 * This is similar to IS_ENABLED(), but returns false when invoked from
 * built-in code when CONFIG_FOO is set to 'm'.
 */



/*
 * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
 * 0 otherwise.
 */
/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Adapted from arm64 version.
 *
 * GNU linker script for the VDSO library.
 * Heavily based on the vDSO linker scripts for other archs.
 *
 * Copyright (C) 2012-2018 ARM Limited
 */





/* SPDX-License-Identifier: GPL-2.0 */




/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/* const.h: Macros for dealing with constants.  */




/* Some constant macros are used in both assembler and
 * C code.  Therefore we cannot annotate them always with
 * 'UL' and other type specifiers unilaterally.  We
 * use the following macros to deal with this.
 *
 * Similarly, _AT() will cast an expression with a type in C, but
 * leave it unchanged in asm.
 */

/*
 * This returns a constant expression while determining if an argument is
 * a constant expression, most importantly without evaluating the argument.
 * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
 */
/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Based on arch/arm/include/asm/page.h
 *
 * Copyright (C) 1995-2003 Russell King
 * Copyright (C) 2012 ARM Ltd.
 */




/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Based on arch/arm/include/asm/page.h
 *
 * Copyright (C) 1995-2003 Russell King
 * Copyright (C) 2017 ARM Ltd.
 */





/* PAGE_SHIFT determines the page size */
/* SPDX-License-Identifier: GPL-2.0 */
/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (C) 2012 ARM Limited
 */



/*
 * Default link address for the vDSO.
 * Since we randomise the VDSO mapping, there's little point in trying
 * to prelink this.
 */

OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
 PROVIDE_HIDDEN(_vdso_data = . - 2 * (1 << 12));

 PROVIDE_HIDDEN(_timens_data = _vdso_data + (1 << 12));

 . = 0x0 + SIZEOF_HEADERS;

 .hash : { *(.hash) } :text
 .gnu.hash : { *(.gnu.hash) }
 .dynsym : { *(.dynsym) }
 .dynstr : { *(.dynstr) }
 .gnu.version : { *(.gnu.version) }
 .gnu.version_d : { *(.gnu.version_d) }
 .gnu.version_r : { *(.gnu.version_r) }

 .note : { *(.note.*) } :text :note

 .dynamic : { *(.dynamic) } :text :dynamic

 .rodata : { *(.rodata*) } :text

 .text : { *(.text*) } :text =0xe7f001f2

 .got : { *(.got) }
 .rel.plt : { *(.rel.plt) }

 /DISCARD/ : {
  *(.note.GNU-stack)
  *(.data .data.* .gnu.linkonce.d.* .sdata*)
  *(.bss .sbss .dynbss .dynsbss)
 }
}

/*
 * We must supply the ELF program headers explicitly to get just one
 * PT_LOAD segment, and set the flags explicitly to make segments read-only.
 */
PHDRS
{
 text PT_LOAD FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
 dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
 note PT_NOTE FLAGS(4); /* PF_R */
}

VERSION
{
 LINUX_2.6 {
 global:
  __vdso_clock_gettime;
  __vdso_gettimeofday;
  __vdso_clock_getres;
  __vdso_clock_gettime64;
 local: *;
 };
}
