################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
drivers/cfal96x64x16.obj: C:/ti/TivaWare_C_Series-1.1/examples/boards/dk-tm4c123g/drivers/cfal96x64x16.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv5/tools/compiler/arm_5.0.4/bin/armcl" -mv7M4 --code_state=16 --float_support=FPv4SPD16 --abi=eabi -me -O2 --include_path="C:/ti/ccsv5/tools/compiler/arm_5.0.4/include" --include_path="C:/ti/TivaWare_C_Series-1.1/examples/boards/dk-tm4c123g" --include_path="C:/ti/TivaWare_C_Series-1.1" --gcc --define=ccs="ccs" --define=PART_TM4C123GH6PGE --define=TARGET_IS_BLIZZARD_RA1 --diag_warning=225 --display_error_number --diag_wrap=off --gen_func_subsections=on --ual --preproc_with_compile --preproc_dependency="drivers/cfal96x64x16.pp" --obj_directory="drivers" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


