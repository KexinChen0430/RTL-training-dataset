module sync_fifo (
   push,
   burst,
   burst_count,
   push_dat,
   pop,
   pop_dat,
   pop_dat_vld ,
   full,
   afull,
   empty,
   clk,
   reset
  );
    input            push;          
    input            burst;         
    input [6:0]      burst_count;   
    input   [31:0]   push_dat;      
    input            pop;           
    output  [31:0]   pop_dat;       
    output           pop_dat_vld;   
    output           full;          
    output           afull;         
    output           empty;         
    input            clk;           
    input            reset;         
    logic            full;
    logic            afull;
    bit [31:0]       fifo[FIFO_DEPTH-1:0]; 
    bit [31:0]       wr_ptr;               
    bit [31:0]       rd_ptr;               
    bit [6:0]        count;                
    logic  [31:0]    pop_dat;
    logic            pop_dat_vld;
    integer          verbose = 0;
    assign pop_dat  = fifo[rd_ptr];         
    assign empty    = (rd_ptr == wr_ptr);   
    initial begin
        for (int jj=0;jj<FIFO_DEPTH;jj++) begin
            fifo[jj]   = 0;                 
        end
        wr_ptr = 0;                         
        rd_ptr = 0;                         
        full   = 0;                         
        afull   = 0;                        
    end 
    assign pop_dat_vld = (pop && (wr_ptr != rd_ptr));
    always @(negedge clk) begin
        if (!reset) begin
            if (pop && (wr_ptr != rd_ptr)) begin
                fifo[rd_ptr]  <= 0;          
                rd_ptr        <= fifo_ptr_inc(rd_ptr); 
            end
            count = 1;
            if (push) begin
                fifo_push(push_dat);         
                if (burst)                   
                    while (count != burst_count) 
                        fifo_push(push_dat + count++);
            end
        end
    end
    always @(wr_ptr or rd_ptr) begin
        full     = (fifo_space() == 0);      
        afull    = (fifo_avail(AFULL_SIZE)== 0 ); 
    end
    task fifo_push(
        input [31:0]        ddr_rq);
    begin
        if (fifo_space()) begin
            if (verbose>10)
                $display("%t: fifo_model: OutputQ.Push :  rq:%0d; wr_ptr:%0d, rd_ptr:%0d",
                $time, ddr_rq, wr_ptr, rd_ptr );
            fifo[wr_ptr] = ddr_rq;          
            wr_ptr = fifo_ptr_inc(wr_ptr);  
        end
        else begin
            $display("%t:%m: attempting to write to fifo but no space left",
                $time);
            $display("%t: Q.Push :  rd_ptr:%0d; wr_ptr:%0d",
                $time, rd_ptr, wr_ptr );
            $finish();
        end
    end
    endtask
    function bit [31:0] fifo_ptr_inc;
        input bit [31:0]    ptr;
    begin
        fifo_ptr_inc = (ptr==(FIFO_DEPTH-1))? 0: ptr+1; 
    end
    endfunction
    function logic fifo_space();
    begin
        fifo_space=  fifo_avail(1);          
    end
    endfunction
    function logic fifo_avail(bit[15:0] num = 1);
    begin
        fifo_avail=    wr_ptr == rd_ptr      || 
                     ( rd_ptr >  wr_ptr &&      
                      (rd_ptr -  wr_ptr >  num)) || 
                     ( wr_ptr >  rd_ptr &&       
                      ( FIFO_DEPTH-1 -           
                      (wr_ptr -  rd_ptr) >= num)) ;
    end
    endfunction
endmodule