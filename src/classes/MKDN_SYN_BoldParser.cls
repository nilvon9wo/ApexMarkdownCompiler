public class MKDN_SYN_BoldParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_BoldParser INSTANCE;
	private static final Integer TOKENS_CONSUMED = 5;
	
	public static MKDN_SYN_BoldParser getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new MKDN_SYN_BoldParser();
		}
		return INSTANCE;
	}
	
    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	if (tokenList.size() < 5) {
    		return MKDN_ND_NullNode.getInstance();
    	}
    	
    	List<MKDN_TKN_Token> syntaxTokenList = new List<MKDN_TKN_Token>{
    		tokenList[0], tokenList[1], tokenList[3], tokenList[4]
    	}; 
    	
    	MKDN_TKN_Token token = tokenList[2];
    	return (
    		(MKDN_TKN_TokenTypeEnum.TEXT.equals(token.tokenType))
    		&& (this.areAllUnderscore(syntaxTokenList) || this.areAllStar(syntaxTokenList))  
    	) 
    		? new MKDN_ND_Node(MKDN_ND_NodeTypeEnum.BOLD, token.value, TOKENS_CONSUMED)
    		: MKDN_ND_NullNode.getInstance(); 
    }
    
    private Boolean areAllUnderscore(List<MKDN_TKN_Token> syntaxTokenList) {
    	for (MKDN_TKN_Token token : syntaxTokenList) {
    		if (!MKDN_TKN_TokenTypeEnum.UNDERSCORE.equals(token.tokenType)) {
    			return false;
    		}
    	}
    	return true;
    }

    private Boolean areAllStar(List<MKDN_TKN_Token> syntaxTokenList) {
    	for (MKDN_TKN_Token token : syntaxTokenList) {
    		if (!MKDN_TKN_TokenTypeEnum.STAR.equals(token.tokenType)) {
    			return false;
    		}
    	}
    	return true;
    }
}