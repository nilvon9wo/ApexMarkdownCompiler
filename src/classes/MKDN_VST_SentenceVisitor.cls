public class MKDN_VST_SentenceVisitor implements MKDN_VST_VisitorIntf {
	private static MKDN_VST_SentenceVisitor INSTANCE;

	Map<MKDN_ND_NodeTypeEnum, MKDN_VST_VisitorIntf> visitorInstanceByNodeTypeMap;
    private MKDN_VST_SentenceVisitor(Map<MKDN_ND_NodeTypeEnum, MKDN_VST_VisitorIntf> visitorInstanceByNodeTypeMap){
    	this.visitorInstanceByNodeTypeMap = visitorInstanceByNodeTypeMap;
    }
    
    private MKDN_VST_SentenceVisitor(){
    	this(new Map<MKDN_ND_NodeTypeEnum, MKDN_VST_VisitorIntf>{
    		MKDN_ND_NodeTypeEnum.BOLD => MKDN_VST_BoldVisitor.getInstance(),
    		MKDN_ND_NodeTypeEnum.EMPHASIS => MKDN_VST_EmphasisVisitor.getInstance(),
    		MKDN_ND_NodeTypeEnum.TEXT => MKDN_VST_TextVisitor.getInstance()
    	}); 
    }
	
    public static MKDN_VST_SentenceVisitor getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_VST_SentenceVisitor();
    	} 
    	return INSTANCE; 
    }	 
    public String visit (MKDN_ND_Node node) {
		MKDN_ND_SentenceNode sentenceNode;
		try {
			sentenceNode = (MKDN_ND_SentenceNode) node;
		}
		catch (System.TypeException ex) {
			throw new MKDN_VST_UnexpectedNodeException ('ParagraphVisitor supports only MKDN_ND_SentenceNode, received: ' + node, ex);
		}

		List<String> wordList = new List<String>();
		for (MKDN_ND_Node word : sentenceNode.wordList) {
	    	MKDN_ND_NodeTypeEnum nodeType = word.nodeType;
	    	MKDN_VST_VisitorIntf visitor = this.visitorInstanceByNodeTypeMap.get(nodeType);
	    	if (visitor == null) {
	    		throw new MKDN_VST_UnexpectedNodeException('Unsupported word node type: ' + nodeType);
	    	}
	    	String html = visitor.visit(word);
			wordList.add(html);		
		}
    	return String.join(wordList, '');
    }
}