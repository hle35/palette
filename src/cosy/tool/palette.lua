r e t u r n   f u n c t i o n   ( L a y e r ,   p a l e t t e ,   r e f )  
  
     l o c a l   m e t a         =   L a y e r . k e y . m e t a  
     l o c a l   r e f i n e s   =   L a y e r . k e y . r e f i n e s  
     l o c a l   t o o l         =   L a y e r . r e q u i r e   " c o s y / f o r m a l i s m / t o o l "  
     l o c a l   g r a p h       =   L a y e r . r e q u i r e   " c o s y / f o r m a l i s m / g r a p h "  
  
     p a l e t t e   [ r e f i n e s ]   =   {  
         t o o l  
     }  
  
     p a l e t t e . d e s c r i p t i o n   =   " C o m p u t e s   # v e r t i c e s   a n d   # e d g e s   o f   a   g r a p h . "  
  
     p a l e t t e . g r a p h   =   {  
         [ r e f i n e s ]       =   {   r e f   [ m e t a ] . p a r a m e t e r _ t y p e   } ,  
         n a m e                 =   " g r a p h " ,  
         d e s c r i p t i o n   =   " g r a p h   t o   a n a l y z e " ,  
         d e f a u l t           =   n i l ,  
         t y p e                 =   g r a p h ,  
         u p d a t e             =   t r u e ,  
     }  
  
     p a l e t t e . r u n   =   f u n c t i o n   ( o p t i o n s )  
         l o c a l   m o d e l   =   o p t i o n s . m o d e l . g r a p h  
         m o d e l . n b _ v e r t i c e s   =   0  
         m o d e l . n b _ e d g e s         =   0  
         f o r   _   i n   p a i r s   ( m o d e l . v e r t i c e s )   d o  
             m o d e l . n b _ v e r t i c e s   =   m o d e l . n b _ v e r t i c e s + 1  
         e n d  
         f o r   _   i n   p a i r s   ( m o d e l . e d g e s )   d o  
             m o d e l . n b _ e d g e s   =   m o d e l . n b _ e d g e s + 1  
         e n d  
         p r i n t   ( " # v e r t i c e s : " ,   m o d e l . n b _ v e r t i c e s )  
         p r i n t   ( " # e d g e s       : " ,   m o d e l . n b _ e d g e s       )  
     e n d  
  
     r e t u r n   p a l e t t e  
  
 e n d  
 