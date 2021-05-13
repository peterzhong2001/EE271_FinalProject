onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pattern_generator_testbench/CLOCK_50
add wave -noupdate /pattern_generator_testbench/reset
add wave -noupdate /pattern_generator_testbench/out
add wave -noupdate /pattern_generator_testbench/dut/in
add wave -noupdate /pattern_generator_testbench/dut/a
add wave -noupdate /pattern_generator_testbench/dut/count
add wave -noupdate /pattern_generator_testbench/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1046 ps} 0}
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
WaveRestoreZoom {0 ps} {7298 ps}
