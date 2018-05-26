// @see: https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/ 
public class MKDN_Tokenizer {
	private static MKDN_Tokenizer INSTANCE;
	
	List<MKDN_SCN_ScannerIntf> scannerList;
    
    private MKDN_Tokenizer(List<MKDN_SCN_ScannerIntf> scannerList) {
    	this.scannerList = scannerList;
    }
    
    private MKDN_Tokenizer() {
    	this(new List<MKDN_SCN_ScannerIntf>{
    		MKDN_SCN_SimpleScanner.getInstance(), 
    		MKDN_SCN_TextScanner.getInstance()
    	});
    }
    
    public static MKDN_Tokenizer getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_Tokenizer();
    	}
    	return INSTANCE;
    }
    
    public List<MKDN_TKN_Token> tokenize(String plainMarkdown) {
    	return this.tokenize(plainMarkdown, new List<MKDN_TKN_Token>());
    }    
    
    private List<MKDN_TKN_Token> tokenize(String plainMarkdown, List<MKDN_TKN_Token> tokenList) {
    	if (String.isBlank(plainMarkdown)) {
    		tokenList.add(MKDN_TKN_EndOfFileToken.getInstance());
    		return tokenList;
    	}
    	
    	MKDN_TKN_Token token = scanOneToken(plainMarkdown);
    	String remainingMarkdown = plainMarkdown.right(plainMarkdown.length() - token.value.length());

    	tokenList.add(token);
    	tokenList.addAll(this.tokenize(remainingMarkdown, tokenList));
    	return tokenList;
    }
    
    private MKDN_TKN_Token scanOneToken(String plainMarkdown) {
    	for (MKDN_SCN_ScannerIntf scanner : scannerList) {
    		MKDN_TKN_Token token = scanner.fromString(plainMarkdown);
    		if (!token.isNull()) {
    			return token;
    		}
    	}
    	throw new MKDN_UnmatchableInputException('The scanners could not match the given input: ' + plainMarkdown);
    }
}