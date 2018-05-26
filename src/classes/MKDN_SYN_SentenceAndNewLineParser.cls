public class MKDN_SYN_SentenceAndNewLineParser implements MKDN_SYN_ParserIntf {
	private static MKDN_SYN_SentenceAndNewLineParser INSTANCE;
	private static final String SENTENCE_LIST = 'sentenceList';
	private static final String CONSUMED_QUANTITY = 'consumed';
    MKDN_SYN_SentenceParser sentenceParser;

    private MKDN_SYN_SentenceAndNewLineParser(MKDN_SYN_SentenceParser sentenceParser) {
    	this.sentenceParser = sentenceParser;
    }
    
    private MKDN_SYN_SentenceAndNewLineParser() {
    	this(MKDN_SYN_SentenceParser.getInstance());
    }

    public static MKDN_SYN_SentenceAndNewLineParser getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SYN_SentenceAndNewLineParser();
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
    	return (this.hasTwoNewLines(tokenList, consumed))
    		? (MKDN_ND_Node) new MKDN_ND_ParagraphNode(sentenceList, consumed + 2)
    		: (MKDN_ND_Node) MKDN_ND_NullNode.getInstance(); 
    }
    
    private Map<String, Object> extractSentences(List<MKDN_TKN_Token> tokenList) {
    	List<MKDN_TKN_Token> workingList = tokenList.clone();
    	
    	List<MKDN_ND_Node> sentenceList = new List<MKDN_ND_Node>();
    	Integer consumed = 0;
    	for (Integer i = 0; i < workingList.size(); i++) {
    		MKDN_ND_Node sentence = this.sentenceParser.match(workingList);
    		if (!sentence.isNull()) {
    			sentenceList.add(sentence);
    			consumed += sentence.consumed;
    			for (Integer j = sentence.consumed - 1; j > -1; j--) {
    				workingList.remove(j);
    			}
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
    
    private Boolean hasTwoNewLines(List<MKDN_TKN_Token> tokenList, Integer consumed) {
    	if (consumed + 2 > tokenList.size()) {
    		return false;
    	}
    	
    	List<MKDN_TKN_Token> syntaxTokenList = new List<MKDN_TKN_Token>{
    		tokenList[consumed], tokenList[consumed + 1]
    	};     	
    	
    	for (MKDN_TKN_Token token : syntaxTokenList) {
    		if (!MKDN_TKN_TokenTypeEnum.NEWLINE.equals(token.tokenType)) {
    			return false;
    		}
    	}
    	return true;
    }
    
}