public class MKDN_ND_ParagraphNode extends MKDN_ND_Node {
    public List<MKDN_ND_Node> sentenceList {get; private set;}
    
    public MKDN_ND_ParagraphNode(List<MKDN_ND_Node> sentenceList, Integer consumed) {
    	this.sentenceList = sentenceList;
    	this.nodeType = MKDN_ND_NodeTypeEnum.PARAGRAPH;
    	this.consumed = consumed;
    }
}