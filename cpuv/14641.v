module mymod (out1, out2, state, reset);
   input [8:0] state;
   input       reset;
   output      out1, out2;
   assign out1 = (state > `ADC_DATA_OFFSET) ? 1 : 0;
   assign out2 = (state > (`ADC_CHANELS + `ADC_DATA_OFFSET + 1)) || (reset);
endmodule 