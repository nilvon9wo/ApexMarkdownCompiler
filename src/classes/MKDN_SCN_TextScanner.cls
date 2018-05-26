public class MKDN_SCN_TextScanner implements MKDN_SCN_ScannerIntf  {
	MKDN_SCN_SimpleScanner simpleScanner;
	
	private static MKDN_SCN_TextScanner INSTANCE;
	
    private MKDN_SCN_TextScanner(MKDN_SCN_SimpleScanner simpleScanner){
    	this.simpleScanner = simpleScanner;
    }

    private MKDN_SCN_TextScanner(){
    	this(MKDN_SCN_SimpleScanner.getInstance());
    }
    
    public static MKDN_SCN_TextScanner getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SCN_TextScanner();
    	} 
    	return INSTANCE; 
    }
    
    public MKDN_TKN_Token fromString(String plainMarkdown) {
    	try {
    		return new MKDN_TKN_Token(MKDN_TokenTypeEnum.TEXT, extractText(plainMarkdown));
    	}
    	catch (MKDN_InvalidTokenException ex) {
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