public class MKDN_SYN_BodyParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_BodyParser INSTANCE;
	private static final String PARAGRAPH_LIST = 'paragraphList';
	private static final String CONSUMED_QUANTITY = 'consumed';
    MKDN_SYN_ParagraphParser paragraphParser;

    private MKDN_SYN_BodyParser(MKDN_SYN_ParagraphParser paragraphParser) {
    	this.paragraphParser = paragraphParser;
    }
    
    private MKDN_SYN_BodyParser() {
    	this(MKDN_SYN_ParagraphParser.getInstance());
    }

    public static MKDN_SYN_BodyParser getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SYN_BodyParser();
    	}
    	return INSTANCE;
    }

    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	Map<String, Object> consumedData = extractParagraphs(tokenList);
    	List<MKDN_ND_Node> paragraphList = (List<MKDN_ND_Node>) consumedData.get(PARAGRAPH_LIST);
    	if (paragraphList.isEmpty()) {
    		return MKDN_ND_NullNode.getInstance();
    	}
    	
    	Integer consumed = (Integer) consumedData.get(CONSUMED_QUANTITY);
    	return  new MKDN_ND_BodyNode(paragraphList, consumed); 
    }
    
    private Map<String, Object> extractParagraphs(List<MKDN_TKN_Token> tokenList) {
    	List<MKDN_TKN_Token> workingList = tokenList.clone();
    	
    	List<MKDN_ND_Node> paragraphList = new List<MKDN_ND_Node>();
    	Integer consumed = 0;
    	for (Integer i = 0; i < workingList.size(); i++) {
    		MKDN_ND_Node paragraph = this.paragraphParser.match(workingList);
    		if (!paragraph.isNull()) {
    			paragraphList.add(paragraph);
    			consumed += paragraph.consumed;
    			for (Integer j = paragraph.consumed - 1; j > -1; j--) {
    				workingList.remove(j);
    			}
    			
    		}
    		else {
    			break;
    		}
    	}
    	return new Map<String, Object> {
    		PARAGRAPH_LIST => paragraphList,
    		CONSUMED_QUANTITY => consumed
    	};
    	
    }
}