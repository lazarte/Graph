//
// Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program located at the root of the software package
// in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
//

import XCTest
import GraphKit

class ProbabilityTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testOrderedSetInt() {
		let s: OrderedSet<Int> = OrderedSet<Int>()
		
		s.insert(1, 2, 3, 3)
		
		let ev: Double = 16 * s.probabilityOf(2, 3)
		
		XCTAssert(ev == s.expectedValueOf(16, elements: 2, 3), "Test failed.")
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}
	
	func testOrderedMultiSetInt() {
		let s: OrderedSet<Int> = OrderedSet<Int>()
		
		s.insert(1, 2, 3, 3)
		
		let ev: Double = 16 * s.probabilityOf(2, 3)
		
		XCTAssert(ev == s.expectedValueOf(16, elements: 2, 3), "Test failed.")
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}
	
	func testOrderedDictionaryInt() {
		let s: OrderedDictionary<Int, Int> = OrderedDictionary<Int, Int>()
		
		s.insert((1, 1))
		s.insert((2, 2))
		s.insert((3, 3))
		s.insert((3, 3))
		
		let ev: Double = 16 * s.probabilityOf(2, 3)
		
		XCTAssert(ev == s.expectedValueOf(16, elements: 2, 3), "Test failed.")
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}
	
	func testOrderedMultiDictionaryInt() {
		let s: OrderedMultiDictionary<Int, Int> = OrderedMultiDictionary<Int, Int>()
		
		s.insert((1, 1))
		s.insert((2, 2))
		s.insert((3, 3))
		s.insert((3, 3))
		
		let ev: Double = 16 * s.probabilityOf(2, 3)
		
		XCTAssert(ev == s.expectedValueOf(16, elements: 2, 3), "Test failed.")
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}
	
	func testEntity() {
		let graph: Graph = Graph()
		let target: Entity = Entity(type: "ProbTest")
		for _ in 0..<99 {
			let _: Entity = Entity(type: "ProbTest")
		}
		graph.save()
		
		let entities: OrderedSet<Entity> = graph.search(Entity: "ProbTest")
		XCTAssert(0.01 == entities.probabilityOf(target), "Test failed.")
		
		for e in entities {
			e.delete()
		}
		graph.save()
	}
	
	func testAction() {
		let graph = Graph()
		let books = OrderedMultiSet<String>()
		
		for purchase in graph.search(Action: "Purchased") {
			for object in purchase.objects {
				if "Book" == object.type {
					books.insert(object["genre"] as! String)
				}
			}
		}
		
		if books.probabilityOf("Physics") > 0.5 {
			// offer physics books
		} else {
			// offer other books
		}
	}

	func testPerformance() {
		self.measureBlock() {}
	}
}
