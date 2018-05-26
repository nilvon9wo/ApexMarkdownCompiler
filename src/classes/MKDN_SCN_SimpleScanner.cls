public class MKDN_SCN_SimpleScanner implements MKDN_SCN_ScannerIntf {
	private static MKDN_SCN_SimpleScanner INSTANCE;
	
    private MKDN_SCN_SimpleScanner(){
    }
    
    public static MKDN_SCN_SimpleScanner getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SCN_SimpleScanner();
    	} 
    	return INSTANCE; 
    }
    
    private static final Map<String, MKDN_TokenTypeEnum> CHARACTER_TO_TYPE_MAP = new Map<String, MKDN_TokenTypeEnum>{
    	'_' => MKDN_TokenTypeEnum.UNDERSCORE,
    	'*' => MKDN_TokenTypeEnum.STAR,
    	'\n' => MKDN_TokenTypeEnum.NEWLINE
    }; 
    
    public MKDN_TKN_Token fromString(String plainMarkdown) {
    	String character = plainMarkdown.left(1);
    	try {
    		return new MKDN_TKN_Token(CHARACTER_TO_TYPE_MAP.get(character), character);
    	}
    	catch (MKDN_InvalidTokenException ex) {
    		return MKDN_TKN_NullToken.getInstance();
    	}
    }    
}