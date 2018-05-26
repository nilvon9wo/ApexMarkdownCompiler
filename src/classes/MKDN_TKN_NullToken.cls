public class MKDN_TKN_NullToken extends MKDN_TKN_Token{
	private static MKDN_TKN_NullToken INSTANCE;
	
    private MKDN_TKN_NullToken(){
    }
    
    public static MKDN_TKN_NullToken getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_TKN_NullToken();
    	} 
    	return INSTANCE; 
    }

    public override Boolean isNull() {
    	return true;
    }
}