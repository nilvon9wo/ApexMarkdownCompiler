public class MKDN_LEX_SimpleScanner implements MKDN_LEX_ScannerIntf {
	private static MKDN_LEX_SimpleScanner INSTANCE;
	
    private MKDN_LEX_SimpleScanner(){
    }
    
    public static MKDN_LEX_SimpleScanner getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_LEX_SimpleScanner();
    	} 
    	return INSTANCE; 
    }
    
    private static final Map<String, MKDN_TKN_TokenTypeEnum> CHARACTER_TO_TYPE_MAP = new Map<String, MKDN_TKN_TokenTypeEnum>{
    	'_' => MKDN_TKN_TokenTypeEnum.UNDERSCORE,
    	'*' => MKDN_TKN_TokenTypeEnum.STAR,
    	'\n' => MKDN_TKN_TokenTypeEnum.NEWLINE
    }; 
    
    public MKDN_TKN_Token fromString(String plainMarkdown) {
    	String character = plainMarkdown.left(1);
    	try {
    		return new MKDN_TKN_Token(CHARACTER_TO_TYPE_MAP.get(character), character);
    	}
    	catch (MKDN_TKN_InvalidTokenException ex) {
    		return MKDN_TKN_NullToken.getInstance();
    	}
    }    
}