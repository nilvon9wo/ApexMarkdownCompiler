// @see: https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/ 
public class MKDN_TKN_Tokenizer {
	private static MKDN_TKN_Tokenizer INSTANCE;
	
	List<MKDN_LEX_ScannerIntf> scannerList;
    
    private MKDN_TKN_Tokenizer(List<MKDN_LEX_ScannerIntf> scannerList) {
    	this.scannerList = scannerList;
    }
    
    private MKDN_TKN_Tokenizer() {
    	this(new List<MKDN_LEX_ScannerIntf>{
    		MKDN_LEX_SimpleScanner.getInstance(), 
    		MKDN_LEX_TextScanner.getInstance()
    	});
    }
    
    public static MKDN_TKN_Tokenizer getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_TKN_Tokenizer();
    	}
    	return INSTANCE;
    }
    
    public List<MKDN_TKN_Token> tokenize(String plainMarkdown) {
    	return this.tokenize(plainMarkdown, new List<MKDN_TKN_Token>());
    }    
    
    private List<MKDN_TKN_Token> tokenize(String plainMarkdown, List<MKDN_TKN_Token> tokenList) {
    	if (plainMarkdown == null || plainMarkdown.equals('')) {
    		tokenList.add(MKDN_TKN_EndOfFileToken.getInstance());
    		return tokenList;
    	}
    	
    	MKDN_TKN_Token token = scanOneToken(plainMarkdown);
    	String remainingMarkdown = plainMarkdown.right(plainMarkdown.length() - token.value.length());

    	tokenList.add(token);
    	this.tokenize(remainingMarkdown, tokenList);
    	return tokenList;
    }
    
    private MKDN_TKN_Token scanOneToken(String plainMarkdown) {
    	for (MKDN_LEX_ScannerIntf scanner : scannerList) {
    		MKDN_TKN_Token token = scanner.fromString(plainMarkdown);
    		if (!token.isNull()) {
    			return token;
    		} 
    	}
    	throw new MKDN_TKN_UnmatchableInputException('The scanners could not match the given input: ' + plainMarkdown);
    }
}