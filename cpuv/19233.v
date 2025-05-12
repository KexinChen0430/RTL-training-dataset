module bus_mux
  import common_pkg::*;
   (
    bus.slave         bus_master,             
    bus.master        bus_slave[NUM_SLAVES],  
    output logic addr_fault_strb
    );
endmodule