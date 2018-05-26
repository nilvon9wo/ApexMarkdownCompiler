public class MKDN_SYN_TextParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_TextParser INSTANCE;
	private static final Integer TOKENS_CONSUMED = 1;
	
	public static MKDN_SYN_TextParser getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new MKDN_SYN_TextParser();
		}
		return INSTANCE;
	}
	
    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	MKDN_TKN_Token token = tokenList[0];
    	return (MKDN_TKN_TokenTypeEnum.TEXT.equals(token.tokenType)) 
    		? new MKDN_ND_Node(MKDN_ND_NodeTypeEnum.TEXT, token.value, TOKENS_CONSUMED)
    		: MKDN_ND_NullNode.getInstance(); 
    }
}