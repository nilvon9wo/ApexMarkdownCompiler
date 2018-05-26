public class MKDN_SYN_EmphasisParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_EmphasisParser INSTANCE;
	private static final Integer TOKENS_CONSUMED = 3;
	
	public static MKDN_SYN_EmphasisParser getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new MKDN_SYN_EmphasisParser();
		}
		return INSTANCE;
	}
		
    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	if (tokenList.size() < 3) {
    		return MKDN_ND_NullNode.getInstance();
    	}
    	
    	List<MKDN_TKN_Token> syntaxTokenList = new List<MKDN_TKN_Token>{
    		tokenList[0], tokenList[2]
    	}; 
    	
    	MKDN_TKN_Token token = tokenList[1];
    	return (
    		(MKDN_TKN_TokenTypeEnum.TEXT.equals(token.tokenType))
    		&& (this.areAllUnderscore(syntaxTokenList) || this.areAllStar(syntaxTokenList))  
    	) 
    		? new MKDN_ND_Node(MKDN_ND_NodeTypeEnum.EMPHASIS, token.value, TOKENS_CONSUMED)
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