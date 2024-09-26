
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw_i[0]}]

set_property PACKAGE_PIN J1 [get_ports run_i]
set_property PACKAGE_PIN N15 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS25 [get_ports run_i]
create_clock -period 10.000 [get_ports clk]




set_property IOSTANDARD LVCMOS33 [get_ports {Bval[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[0]}]
set_property PACKAGE_PIN D15 [get_ports {Bval[3]}]
set_property PACKAGE_PIN D14 [get_ports {Bval[2]}]
set_property PACKAGE_PIN C14 [get_ports {Bval[1]}]
set_property PACKAGE_PIN C13 [get_ports {Bval[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {Din[7]}]
set_property PACKAGE_PIN D16 [get_ports {Bval[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Bval[7]}]
set_property PACKAGE_PIN F18 [get_ports {Bval[5]}]
set_property PACKAGE_PIN E17 [get_ports {Bval[6]}]
set_property PACKAGE_PIN D17 [get_ports {Bval[7]}]



set_property PACKAGE_PIN C18 [get_ports {Aval[4]}]
set_property PACKAGE_PIN D18 [get_ports {Aval[5]}]
set_property PACKAGE_PIN E18 [get_ports {Aval[6]}]
set_property PACKAGE_PIN G17 [get_ports {Aval[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Aval[0]}]
set_property PACKAGE_PIN B17 [get_ports {Aval[3]}]
set_property PACKAGE_PIN C17 [get_ports {Aval[0]}]
set_property PACKAGE_PIN B18 [get_ports {Aval[1]}]
set_property PACKAGE_PIN A17 [get_ports {Aval[2]}]








set_property PACKAGE_PIN E6  [get_ports {hex_segA[0]}]
set_property PACKAGE_PIN B4  [get_ports {hex_segA[1]}]
set_property PACKAGE_PIN D5 [get_ports {hex_segA[2]}]
set_property PACKAGE_PIN C5  [get_ports {hex_segA[3]}]
set_property PACKAGE_PIN  D7 [get_ports {hex_segA[4]}]
set_property PACKAGE_PIN  D6 [get_ports {hex_segA[5]}]
set_property PACKAGE_PIN  C4 [get_ports {hex_segA[6]}]
set_property PACKAGE_PIN  B5 [get_ports {hex_segA[7]}]

set_property PACKAGE_PIN G6  [get_ports {hex_gridA[0]}]
set_property PACKAGE_PIN H6  [get_ports {hex_gridA[1]}]
set_property PACKAGE_PIN C3  [get_ports {hex_gridA[2]}]
set_property PACKAGE_PIN B3  [get_ports {hex_gridA[3]}]



set_property IOSTANDARD LVCMOS25 [get_ports {hex_gridA[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_gridA[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_gridA[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_gridA[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hex_segA[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports reset_load_clr]
set_property PACKAGE_PIN J2 [get_ports reset_load_clr]
set_property PACKAGE_PIN C9 [get_ports sign_LED]
set_property IOSTANDARD LVCMOS33 [get_ports sign_LED]

set_property IOSTANDARD LVCMOS33 [get_ports {Led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Led[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {Led[2]}]
