public class MKDN_SYN_SentenceAndEndOfFileParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_SentenceAndEndOfFileParser INSTANCE;
	private static final String SENTENCE_LIST = 'sentenceList';
	private static final String CONSUMED_QUANTITY = 'consumed';
    MKDN_SYN_SentenceParser sentenceParser;

    private MKDN_SYN_SentenceAndEndOfFileParser(MKDN_SYN_SentenceParser sentenceParser) {
    	this.sentenceParser = sentenceParser;
    }
    
    private MKDN_SYN_SentenceAndEndOfFileParser() {
    	this(MKDN_SYN_SentenceParser.getInstance());
    }

    public static MKDN_SYN_SentenceAndEndOfFileParser getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SYN_SentenceAndEndOfFileParser();
    	}
    	return INSTANCE;
    }

    public MKDN_ND_Node match(List<MKDN_TKN_Token> tokenList) {
    	Map<String, Object> consumedData = extractSentences(tokenList);
    	List<MKDN_ND_Node> sentenceList = (List<MKDN_ND_Node>) consumedData.get(SENTENCE_LIST);
    	if (sentenceList.isEmpty()) {
    		return MKDN_ND_NullNode.getInstance();
    	}
    	
    	Integer consumed = (Integer) consumedData.get(CONSUMED_QUANTITY);
    	Integer charactersTilEndOfFile = this.countCharactersTilEndOfFile(tokenList, consumed); 
    	
		return (charactersTilEndOfFile > 0)
			? (MKDN_ND_Node) new MKDN_ND_ParagraphNode(sentenceList, consumed + charactersTilEndOfFile)
			: (MKDN_ND_Node) MKDN_ND_NullNode.getInstance();
    }
    
    private Map<String, Object> extractSentences(List<MKDN_TKN_Token> tokenList) { 
    	List<MKDN_TKN_Token> workingList = tokenList.clone();
    	
    	List<MKDN_ND_Node> sentenceList = new List<MKDN_ND_Node>();
    	Integer consumed = 0;
    	for (Integer i = 0; i < workingList.size(); i++) {
    		MKDN_ND_Node sentence = this.sentenceParser.match(workingList);
    		if (!sentence.isNull()) {
    			for (Integer j = sentence.consumed - 1; j > -1; j--) {
    				workingList.remove(j);
    			}
    			
    			sentenceList.add(sentence);
    			consumed += sentence.consumed;
    		}
    		else {
    			break;
    		}
    	}
    	
    	return new Map<String, Object> {
    		SENTENCE_LIST => sentenceList,
    		CONSUMED_QUANTITY => consumed
    	};
    }
    
    private Integer countCharactersTilEndOfFile(List<MKDN_TKN_Token> tokenList, Integer consumed) {
    	if (tokenList.size() == consumed) {
    		return 0;
    	}
    	
    	if (MKDN_TKN_TokenTypeEnum.EOF.equals(tokenList[consumed].tokenType)) {
    		return 1; 
    	} 
    	
    	if	( 
    			(consumed + 1 < tokenList.size()) 
    			&& (MKDN_TKN_TokenTypeEnum.NEWLINE.equals(tokenList[consumed].tokenType))
    			&& (MKDN_TKN_TokenTypeEnum.EOF.equals(tokenList[consumed + 1].tokenType))
    		) {
    		return 2;
    	}
    	
    	return 0;
    }
}