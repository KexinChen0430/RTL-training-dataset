module TBCTRL_2 (
  input HRESETn,       
  input HCLK,          
  input HREADYin,      
  input HREADYout,     
  input HWRITEin,      
  input HWRITEout,     
  input HSEL,          
  input HGRANT,        
  output MAPSn,        
  output MDPSn,        
  output DENn,         
  output SDPSn,        
  output SRSn          
);
wire  MasterReadData;          
wire  SlaveAddrPhaseSel;       
wire  MasterAddrPhaseSel;      
reg   MasterDataPhaseSel;      
reg   MRWSel;                  
reg   reg_HGRANT;              
reg SlaveDataPhaseSel;         
reg RWSel;                     
always@(posedge HCLK or negedge HRESETn)
begin
  if(!HRESETn)
    reg_HGRANT <= 1'd0;        
  else
    reg_HGRANT <= HGRANT;      
end
assign DENn = (MDPSn) ? SDPSn : MDPSn;
assign MAPSn = ~MasterAddrPhaseSel;
assign MDPSn = ~(MasterDataPhaseSel & MRWSel);
assign MasterAddrPhaseSel = reg_HGRANT;
assign MasterReadData  =  MasterDataPhaseSel & (~MRWSel);
always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    MasterDataPhaseSel  <= 1'b1; 
  else if (HREADYin)
    MasterDataPhaseSel <= MasterAddrPhaseSel; 
end
always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    MRWSel <= 1'b0; 
  else if (HREADYin)
    MRWSel <= HWRITEout; 
end
assign SlaveAddrPhaseSel  = HSEL;
assign SDPSn   =   ~(SlaveDataPhaseSel & RWSel);
assign SRSn   =  ~SlaveDataPhaseSel;
always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    SlaveDataPhaseSel <= 1'b1; 
  else if (HREADYin)
    SlaveDataPhaseSel <= SlaveAddrPhaseSel; 
end
always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    RWSel <= 1'b0; 
  else if (HREADYin)
    RWSel <= ~HWRITEin; 
end
endmodule 