onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /column_driver_testbench/clk
add wave -noupdate /column_driver_testbench/reset
add wave -noupdate /column_driver_testbench/right_lit
add wave -noupdate /column_driver_testbench/pattern_in
add wave -noupdate /column_driver_testbench/pattern_out
add wave -noupdate /column_driver_testbench/lit
add wave -noupdate /column_driver_testbench/dut/temp_out
add wave -noupdate /column_driver_testbench/dut/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1571 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1500 ps} {2500 ps}
