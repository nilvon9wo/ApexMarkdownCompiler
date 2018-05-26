public class MKDN_TKN_EndOfFileToken extends MKDN_TKN_Token {
	private static MKDN_TKN_EndOfFileToken INSTANCE;
	
    private MKDN_TKN_EndOfFileToken(){
    	this.tokenType = MKDN_TKN_TokenTypeEnum.EOF; 
    	this.value = ''; 
    }
    
    public static MKDN_TKN_EndOfFileToken getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_TKN_EndOfFileToken();
    	} 
    	return INSTANCE; 
    }
}