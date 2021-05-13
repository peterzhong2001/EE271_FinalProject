# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
vlog "./LEDDriver.sv"
vlog "./LED_test.sv"
vlog "./clock_divider.sv"
vlog "./bird.sv"
vlog "./bird_light.sv"
vlog "./input_processing.sv"
vlog "./clock_counter.sv"
vlog "./single_hex_driver.sv"
vlog "./bird_light_center.sv"
vlog "./pattern_generator.sv"
vlog "./column_driver.sv"
vlog "./LFSR.sv"
vlog "./D_FF_R.sv"
vlog "./score_keeper.sv"
vlog "./screen_controller.sv"
vlog "./difficulty_display.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
