public class MKDN_SYN_ParagraphParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_ParagraphParser INSTANCE;
	 
	List<MKDN_SYN_ParserIntf> parserList;
    
    private MKDN_SYN_ParagraphParser(List<MKDN_SYN_ParserIntf> parserList) {
    	this.parserList = parserList;
    }
    
    private MKDN_SYN_ParagraphParser() {
    	this(new List<MKDN_SYN_ParserIntf>{
    		MKDN_SYN_SentenceAndNewLineParser.getInstance(), 
    		MKDN_SYN_SentenceAndEndOfFileParser.getInstance()
    	});
    }
    
    public static MKDN_SYN_ParagraphParser getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SYN_ParagraphParser();
    	}
    	return INSTANCE;
    }
	
    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	for (MKDN_SYN_ParserIntf parser : this.parserList) {
    		MKDN_ND_Node node = parser.match(tokenList);
    		if (!node.isNull()) {
    			return node;
    		}
    	}
    	return MKDN_ND_NullNode.getInstance(); 
    }
}