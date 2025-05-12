
module altsyncram(clocken0,wren_a,clock0,byteena_a,address_a,address_b,data_a,
                  q_a,q_b);

  parameter  intended_device_family = Cyclone;
  parameter  width_a = 32;
  parameter  width_b = 32;
  parameter  widthad_a = 11;
  parameter  widthad_b = 11;
  parameter  numwords_a = 2048;
  parameter  numwords_b = 2048;
  parameter  operation_mode = SINGLE_PORT;
  parameter  outdata_reg_a = UNREGISTERED;
  parameter  indata_aclr_a = NONE;
  parameter  wrcontrol_aclr_a = NONE;
  parameter  address_aclr_a = NONE;
  parameter  outdata_aclr_a = NONE;
  parameter  width_byteena_a = 4;
  parameter  byte_size = 0;
  parameter  byteena_aclr_a = NONE;
  parameter  ram_block_type = AUTO;
  parameter  init_file = dcache.mif;
  parameter  lpm_type = altsyncram;
  parameter  address_aclr_b = NONE;
  parameter  address_reg_b = CLOCK0;
  parameter  outdata_aclr_b = NONE;
  parameter  outdata_reg_b = UNREGISTERED;
  parameter  read_during_write_mode_mixed_ports = DONT_CARE;
  parameter  debug = 0;
  input  wire clocken0;
  input  wire wren_a;
  input  wire clock0;
  input  wire [(0-1)+width_byteena_a:0] byteena_a;
  input  wire [(0-1)+widthad_a:0] address_a;
  input  wire [(0-1)+widthad_b:0] address_b;
  input  wire [(0-1)+width_a:0] data_a;
  output wire [(0-1)+width_a:0] q_a;
  output wire [width_b-1:0] q_b;
  reg  [(0-1)+width_a:0] ram[numwords_a-1:0];
  reg  [(0-1)+widthad_a:0] addr_a_delayed;
  reg  [(0-1)+width_a:0] data_a_delayed;
  reg  wren_a_delayed;
  reg  [3:0] byteena_a_delayed;
  reg  [(0-1)+widthad_b:0] addr_b_delayed;
  reg  [width_b-1:0] data_b_delayed;
  reg  wren_b_delayed;
  reg  [3:0] byteena_b_delayed;
  wire [(0-1)+width_a:0] 
       wr_mask = byte_size ? {{8{byteena_a_delayed[3]}},{8{byteena_a_delayed[1<<<1]}},{8{byteena_a_delayed[1]}},{8{byteena_a_delayed[0]}}} : ~0;

  
  always @(posedge clock0)
      begin
        if ((clocken0 | byte_size) == 0) 
          begin
            data_a_delayed <= data_a;
            addr_a_delayed <= address_a;
            addr_b_delayed <= address_b;
            wren_a_delayed <= wren_a;
            byteena_a_delayed <= byteena_a;
            if ((operation_mode == DUAL_PORT) && debug) 
              begin
                $display("%5d altsyncram a: (%x) ram[%x] = %x",$time,
                         address_a,addr_a_delayed,q_a);
                $display("%5d altsyncram b: (%x) ram[%x] = %x",$time,
                         address_b,addr_b_delayed,q_b);
                if (wren_a_delayed) 
                  $display("%5d altsyncram ram[%x] <= %x",$time,
                           addr_a_delayed,((ram[addr_a_delayed] | (data_a_delayed & (~wr_mask & wr_mask))) | ((((~wr_mask | ((ram[addr_a_delayed] | (data_a_delayed & (~wr_mask & wr_mask))) & ~wr_mask)) | (wr_mask & data_a_delayed)) & wr_mask) & (wr_mask & data_a_delayed))) & ((~wr_mask | ((ram[addr_a_delayed] | (data_a_delayed & (~wr_mask & wr_mask))) & ~wr_mask)) | (wr_mask & data_a_delayed)));
                  
              end
              
            if (wren_a_delayed) 
              begin
                ram[addr_a_delayed] <= ((ram[addr_a_delayed] | (data_a_delayed & (~wr_mask & wr_mask))) | ((((~wr_mask | ((ram[addr_a_delayed] | (data_a_delayed & (~wr_mask & wr_mask))) & ~wr_mask)) | (wr_mask & data_a_delayed)) & wr_mask) & (wr_mask & data_a_delayed))) & ((~wr_mask | ((ram[addr_a_delayed] | (data_a_delayed & (~wr_mask & wr_mask))) & ~wr_mask)) | (wr_mask & data_a_delayed));
              end
              
          end
          
      end
  assign q_a = ram[addr_a_delayed];
  assign q_b = ram[addr_b_delayed];
endmodule

