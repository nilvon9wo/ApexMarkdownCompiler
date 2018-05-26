public class MKDN_SYN_SentenceParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_SentenceParser INSTANCE;
	 
	List<MKDN_SYN_ParserIntf> parserList;
    
    private MKDN_SYN_SentenceParser(List<MKDN_SYN_ParserIntf> parserList) {
    	this.parserList = parserList;
    }
    
    private MKDN_SYN_SentenceParser() {
    	this(new List<MKDN_SYN_ParserIntf>{
    		MKDN_SYN_EmphasisParser.getInstance(), 
    		MKDN_SYN_BoldParser.getInstance(),
    		MKDN_SYN_TextParser.getInstance() 
    	});
    }
    
    public static MKDN_SYN_SentenceParser getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SYN_SentenceParser();
    	}
    	return INSTANCE;
    }
	
    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	List<MKDN_TKN_Token> workingList = tokenList.clone();
    	
    	List<MKDN_ND_Node> wordList = new List<MKDN_ND_Node>();
    	Integer consumed = 0; 
    	for (Integer i = 0; i < workingList.size(); i++) {
    		MKDN_ND_Node node = this.parse(workingList);
    		if (!node.isNull()) {
    			wordList.add(node);
    			consumed += node.consumed;
    			for (Integer j = node.consumed - 1; j > -1; j--) {
    				workingList.remove(j);
    			}
    		}
    		else {
    			break;
    		}
    	}

    	return (!wordList.isEmpty())
    		? (MKDN_ND_Node) new MKDN_ND_SentenceNode(wordList, consumed)
    		: (MKDN_ND_Node) MKDN_ND_NullNode.getInstance(); 
    }
    
    private MKDN_ND_Node parse(List<MKDN_TKN_Token> workingList) {
    	for (MKDN_SYN_ParserIntf parser : this.parserList) {
    		MKDN_ND_Node node = parser.match(workingList);
    		if (!node.isNull()) {
    			return node;
    		}
    	}
    	return MKDN_ND_NullNode.getInstance();
    }
}