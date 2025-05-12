module altpcierd_icm_msibridge (clk, rstn,
                                 data_valid, data_in, data_ack,
                                 msi_ack, msi_req, msi_num, msi_tc);
   input         clk;          
   input         rstn;         
   input         data_valid;   
   input[107:0]  data_in;      
   input         msi_ack;      
   output        data_ack;     
   output        msi_req;      
   output[4:0]   msi_num;      
   output[2:0]   msi_tc;       
   reg           msi_req;      
   reg  [4:0]    msi_num;      
   reg  [2:0]    msi_tc;       
   reg           msi_req_r;    
   wire          throttle_data; 
   assign data_ack  = ~(~msi_ack & (msi_req | (data_valid & data_in[`STREAM_MSI_VALID])));
   always @ (posedge clk or negedge rstn) begin
       if (~rstn) begin 
          msi_num <= 5'h0; 
          msi_tc  <= 3'h0; 
          msi_req <= 1'b0; 
      end
      else begin 
          msi_num <= (data_in[`STREAM_MSI_VALID]) ? data_in[`STREAM_APP_MSI_NUM] : msi_num;
          msi_tc  <= (data_in[`STREAM_MSI_VALID]) ? data_in[`STREAM_MSI_TC] : msi_tc;
          msi_req <= msi_ack ? 1'b0 : (data_valid & data_in[`STREAM_MSI_VALID]) ? 1'b1 : msi_req;
      end
   end
endmodule