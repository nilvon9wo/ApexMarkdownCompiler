public class MKDN_LEX_TextScanner implements MKDN_LEX_ScannerIntf  {
	MKDN_LEX_SimpleScanner simpleScanner;
	
	private static MKDN_LEX_TextScanner INSTANCE;
	
    private MKDN_LEX_TextScanner(MKDN_LEX_SimpleScanner simpleScanner){
    	this.simpleScanner = simpleScanner;
    }

    private MKDN_LEX_TextScanner(){
    	this(MKDN_LEX_SimpleScanner.getInstance());
    }
    
    public static MKDN_LEX_TextScanner getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_LEX_TextScanner();
    	} 
    	return INSTANCE; 
    }
    
    public MKDN_TKN_Token fromString(String plainMarkdown) {
    	try {
    		return new MKDN_TKN_Token(MKDN_TKN_TokenTypeEnum.TEXT, extractText(plainMarkdown));
    	}
    	catch (MKDN_TKN_InvalidTokenException ex) {
    		return MKDN_TKN_NullToken.getInstance();
    	}
    }
    
    private String extractText(String plainMarkdown) {
		String text = '';
    	for (Integer i = 0; i < plainMarkdown.length(); i++) {
	    	String character = plainMarkdown.substring(i, i+1);
	    	MKDN_TKN_Token token = this.simpleScanner.fromString(character);
	    	if (token.isNull()) {
	    		text += character;
	    	}
	    	else {
	    		return text;
	    	}
    	}
    	return text;
    }
        
}